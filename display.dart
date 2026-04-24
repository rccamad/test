import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registered Students")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('students').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No data available"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              var data = doc.data() as Map<String, dynamic>;

              String name = data['name'] ?? '';
              String rollNo = data['rollNo'] ?? "";
              String phoneNo = data['phoneNo'] ?? '';
              String gender = data['gender'];
              String course = data["Course"];

              return ListTile(
                title: Text(name),
                subtitle: Text(
                  "Roll No: $rollNo | Phone NO: $phoneNo | Gender: $gender | course | $course",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _editDialog(context, doc.id, data),
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('students')
                            .doc(doc.id)
                            .delete();
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _editDialog(BuildContext content, String id, Map<String, dynamic> data) {
    final name = TextEditingController(text: data['name'] ?? "");
    final rollNo = TextEditingController(text: data['rollNo'] ?? "");
    final phoneNo = TextEditingController(text: data['phoneNo'] ?? "");
    var gender = data['gender'] ?? 'Male';

    var selectCourse = data['Course'];
    final List<String> courses = ['BCA', 'MCA', 'BCom', 'BBA'];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text("Edit student"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: name,
                      decoration: InputDecoration(labelText: "Name"),
                    ),
                    TextField(
                      controller: rollNo,
                      decoration: InputDecoration(labelText: "Roll No"),
                    ),
                    TextField(
                      controller: phoneNo,
                      decoration: InputDecoration(labelText: "Phone No"),
                    ),
                    Column(
                      children: [
                        Text("Gender"),
                        ListTile(
                          title: Text('Male'),
                          leading: Radio(
                            value: 'Male',
                            groupValue: gender,
                            onChanged: (value) => {
                              setStateDialog(() {
                                gender = value.toString();
                              }),
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('Female'),
                          leading: Radio(
                            value: 'Female',
                            groupValue: gender,
                            onChanged: (value) => {
                              setStateDialog(() {
                                gender = value.toString();
                              }),
                            },
                          ),
                        ),
                      ],
                    ),
                    StatefulBuilder(
                      builder: (contxet, setDialogState) {
                        return DropdownButton<String>(
                          hint: Text("Select an optionn"),
                          value: selectCourse,
                          items: courses.map((String course) {
                            return DropdownMenuItem<String>(
                              child: Text(course),
                              value: course,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setStateDialog(() {
                              selectCourse = value;
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cencel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('students')
                        .doc(id)
                        .update({
                          'name': name.text.trim(),
                          'rollNo': rollNo.text.trim(),
                          'phone': phoneNo.text.trim(),
                          'gender': gender,
                          'Course': selectCourse
                        });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Record updated')));
                  },
                  child: Text("Update"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
