import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text("lingolearn"),
        ),
        actions: const [
          Icon(Icons.settings),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              child: Text("LingoLearn menu"),
            ),
            ListTile(title: Text("Home")),
            ListTile(title: Text("Progress")),
            ListTile(title: Text("Profile")),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Chose a language to learn",
            style: TextStyle(fontSize: 20),
          ),
          RadioListTile(
            title: const Text("English"),
            value: "English",
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value.toString();
              });
            },
          ),
          RadioListTile(
            title: const Text("Spanish"),
            value: "Spanish",
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value.toString();
              });
            },
          ),
          RadioListTile(
            title: const Text("French"),
            value: "French",
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value.toString();
              });
            },
          ),
          RadioListTile(
            title: const Text("German"),
            value: "German",
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value.toString();
              });
            },
          ),
          RadioListTile(
            title: const Text("Japanese"),
            value: "Japanese",
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value.toString();
              });
            },
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LearningScreen(),
                  ),
                );
              },
              child: const Text("Start learning"),
            ),
          ),
        ],
      ),
    );
  }
}

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "welcome to the learning screen",
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          const Text("lesson 1: Basic greetings"),
          const Text("lesson 2: Number"),
          const Text("lesson 3: Common phrases"),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Home"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Start Quiz"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
