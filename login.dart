import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_app2/home.dart';
import 'package:student_app2/register.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(
        children: [
          TextFormField(
            controller: email,
            decoration: InputDecoration(labelText: "Email"),
          ),
          TextFormField(
            controller: password,
            decoration: InputDecoration(labelText: "Password"),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                if (email.text.isEmpty || password.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Firelds are required")),
                  );
                  return;
                }
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email.text,
                  password: password.text,
                );
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Login successful")));
                Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Error: $e")));
              }
            },
            child: Text("Login"),
          ),
          TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen())), child: Text("Dont have an account"))
        ],
      ),
    );
  }
}
