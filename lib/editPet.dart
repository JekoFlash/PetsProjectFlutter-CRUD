import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditPet extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController petNameController;
  final TextEditingController petAgeController;
  final TextEditingController petBreedController;
  final String petId;

  EditPet({
    required this.formKey,
    required this.petNameController,
    required this.petAgeController,
    required this.petBreedController,
    required this.petId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 800,
      padding: EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: 1000,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: Center(
                    child: Text(
                  "Edit Pets Data",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: petNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Pet Name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Pet Name',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Input name : "Jedai, June, Nam, Tae" ',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: petAgeController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Pet Age";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Pet Age',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Input age : "6, 8, 10, 12" ',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    updatePet(petNameController.text, petAgeController.text,
                        petBreedController.text, petId);
                  } else {
                    print("Form is invalid!");
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void updatePet(String name, String age, String breed, String petId) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  await _firestore.collection('Pets').doc(petId).update({
    'Name': name,
    'Age': age,
    'Breed': breed,
  });
}
