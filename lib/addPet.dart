import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPet extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController petNameController;
  final TextEditingController petAgeController;
  final TextEditingController petBreedController;

  AddPet({
    required this.formKey,
    required this.petNameController,
    required this.petAgeController,
    required this.petBreedController,
  });

  @override
  _AddPetState createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 800,
      padding: EdgeInsets.all(10),
      child: Form(
        key: widget.formKey,
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
                  "Add Pets Data",
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
                controller: widget.petNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Pet Name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Pet Name',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Input name : "Jedai" ',
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
                controller: widget.petAgeController,
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
              TextFormField(
                controller: widget.petBreedController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Pet Breed";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Pet Breed',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Input Breed : "Dog Golden, Cat Thai" ',
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
              ElevatedButton(
                onPressed: () {
                  if (widget.formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    addPet(
                        widget.petNameController.text,
                        widget.petAgeController.text,
                        widget.petBreedController.text);
                  } else {
                    print("Form is invalid!");
                  }
                  widget.petNameController.clear();
                  widget.petAgeController.clear();
                  widget.petBreedController.clear();
                  setState(() {});
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

void addPet(String name, String age, String breed) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  await _firestore.collection('Pets').add({
    'Name': name,
    'Age': age,
    'Breed': breed,
  });
}
