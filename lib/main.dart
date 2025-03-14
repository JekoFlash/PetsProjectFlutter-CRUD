import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pets/addPet.dart';
import 'package:pets/editPet.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController _PetNameController = TextEditingController();
  TextEditingController _PetAgeController = TextEditingController();
  TextEditingController _PetBreedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Pets Management',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('Pets').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("No Data"),
              );
            }

            var pets = snapshot.data!.docs;

            return ListView.builder(
              itemCount: pets.length,
              itemBuilder: (context, index) {
                var pet = pets[index];
                var petId = pet.id;

                return Slidable(
                  startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      // Delete Data Pet
                      SlidableAction(
                        onPressed: (context) {
                          deletePet(petId);
                          setState(() {});
                        },
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      // Edit Data Pet
                      SlidableAction(
                        onPressed: (context) {
                          _PetNameController.text = pet['Name'];
                          _PetAgeController.text = pet['Age'];
                          showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            context: context,
                            builder: (context) {
                              return EditPet(
                                formKey: _formKey,
                                petNameController: _PetNameController,
                                petAgeController: _PetAgeController,
                                petBreedController: _PetBreedController,
                                petId: petId,
                              );
                            },
                          );
                        },
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(5, 5),
                              blurRadius: 5.0,
                              spreadRadius: 3.0,
                            )
                          ]),
                      child: ListTile(
                        title: Text(
                          'Pet Name : ' + pet['Name'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Pet Age : ' + pet['Age'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // BottomSheet Add Data Pet
          showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            context: context,
            builder: (context) {
              return AddPet(
                formKey: _formKey,
                petNameController: _PetNameController,
                petAgeController: _PetAgeController,
                petBreedController: _PetBreedController,
              );
            },
          );
          setState(() {});
        },
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void deletePet(String petId) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    await _firestore.collection('Pets').doc(petId).delete();
  }
}
