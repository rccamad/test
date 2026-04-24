import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final name = TextEditingController();
  final rollNo = TextEditingController();
  final phoneNo = TextEditingController();
  var selectedGender = 'Male';
  String? selectCourse;
  final List<String> courses = ['BCA', 'MCA', 'BCom', 'BBA'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register Student")),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              controller: name,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextFormField(
              controller: rollNo,
              decoration: InputDecoration(labelText: "Roll No"),
            ),
            TextFormField(
              controller: phoneNo,
              decoration: InputDecoration(labelText: "Phone Number"),
            ),
            Column(
              children: [
                Text("Select Gender"),
                ListTile(
                  title: Text("Male"),
                  leading: Radio(
                    value: 'Male',
                    groupValue: selectedGender,
                    onChanged: (value) => setState(() {
                      selectedGender = value.toString();
                    }),
                  ),
                ),
                ListTile(
                  title: Text("Female"),
                  leading: Radio(
                    value: "Female",
                    groupValue: selectedGender,
                    onChanged: (value) => setState(() {
                      selectedGender = value.toString();
                    }),
                  ),
                ),
              ],
            ),
            DropdownButton<String>(hint: Text("Select an optionn"), value: selectCourse, items: courses.map((String course) {
              return DropdownMenuItem<String>(child: Text(course), value: course);
            }).toList(), onChanged: (value) {
              setState(() {
                selectCourse = value;
              });
            }),
            ElevatedButton(onPressed: () async {
              try {
                await FirebaseFirestore.instance.collection('students').add({
                  'name' : name.text.trim(),
                  'rollNo': rollNo.text.trim(),
                  'phoneNo': phoneNo.text.trim(),
                  'gender': selectedGender,
                  'Course': selectCourse
                });
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Record created")));
              } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Record creation error: $e")));
                };
            }, child: Text("Submit")),
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen())), child: Text("Display"))
          ],
        ),
      ),
    );
  }
}
