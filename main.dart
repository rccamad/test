import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

// ================= HOME SCREEN WITH DRAWER =================
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Widgets Demo"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Tab 1"),
              Tab(text: "Tab 2"),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  "Menu",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(leading: Icon(Icons.home), title: Text("Home")),
              ListTile(leading: Icon(Icons.settings), title: Text("Settings")),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // ===== TAB 1 =====
            SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SelectableText
                  SelectableText(
                    "This is a SelectableText widget. You can copy me!",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  // DataTable
                  Text(
                    "DataTable Example:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DataTable(
                    columns: [
                      DataColumn(label: Text("Name")),
                      DataColumn(label: Text("Age")),
                    ],
                    rows: [
                      DataRow(
                        cells: [DataCell(Text("Alice")), DataCell(Text("25"))],
                      ),
                      DataRow(
                        cells: [DataCell(Text("Bob")), DataCell(Text("30"))],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text("Charlie")),
                          DataCell(Text("22")),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // ===== TAB 2 =====
            SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Stack Widget Example:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.grey[300],
                    child: Stack(
                      children: [
                        Container(width: 100, height: 100, color: Colors.blue),
                        Positioned(
                          top: 20,
                          left: 50,
                          child: Container(
                            width: 50,
                            height: 50,
                            color: Colors.red,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Text(
                            "Stacked Text",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Use the drawer to navigate!",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
