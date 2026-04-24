import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> hotels = [
    {
      "name": "Taj Hotel",
      "location": "Mumbai",
      "image":""
    },
    {
      "name": "Leela Palace",
      "location": "Delhi",
      "image": ""
    },
    {
      "name": "Oberoi",
      "location": "Bangalore",
      "image": ""
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Hotel Reservation App"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Hotels"),
              Tab(text: "Bookings"),
            ],
          ),
        ),

        // Drawer
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(child: Text("Menu")),
              ListTile(title: Text("Home")),
              ListTile(title: Text("My Bookings")),
              ListTile(title: Text("Contact Us")),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            ListView(
              children: hotels.map((hotel) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(hotel["image"]!),
                  ),
                  title: Text(hotel["name"]!),
                  subtitle: Text(hotel["location"]!),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingScreen(
                          name: hotel["name"]!,
                          image: hotel["image"]!,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            Center(child: Text("No bookings yet")),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}

class BookingScreen extends StatefulWidget {
  final String name;
  final String image;

  BookingScreen({required this.name, required this.image});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  TextEditingController nameController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  String roomType = "Single";

  bool wifi = false;
  bool breakfast = false;
  bool parking = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  widget.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    widget.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Text("4.5", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration:
                        InputDecoration(labelText: "Customer Name"),
                  ),

                  SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      setState(() => selectedDate = date);
                    },
                    child: Text(selectedDate == null
                        ? "Select Date"
                        : selectedDate.toString().split(" ")[0]),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      setState(() => selectedTime = time);
                    },
                    child: Text(selectedTime == null
                        ? "Select Time"
                        : selectedTime!.format(context)),
                  ),

                  SizedBox(height: 10),

                  RadioListTile(
                    title: Text("Single"),
                    value: "Single",
                    groupValue: roomType,
                    onChanged: (val) {
                      setState(() => roomType = val.toString());
                    },
                  ),
                  RadioListTile(
                    title: Text("Double"),
                    value: "Double",
                    groupValue: roomType,
                    onChanged: (val) {
                      setState(() => roomType = val.toString());
                    },
                  ),
                  RadioListTile(
                    title: Text("Deluxe"),
                    value: "Deluxe",
                    groupValue: roomType,
                    onChanged: (val) {
                      setState(() => roomType = val.toString());
                    },
                  ),

                  CheckboxListTile(
                    title: Text("WiFi"),
                    value: wifi,
                    onChanged: (val) {
                      setState(() => wifi = val!);
                    },
                  ),
                  CheckboxListTile(
                    title: Text("Breakfast"),
                    value: breakfast,
                    onChanged: (val) {
                      setState(() => breakfast = val!);
                    },
                  ),
                  CheckboxListTile(
                    title: Text("Parking"),
                    value: parking,
                    onChanged: (val) {
                      setState(() => parking = val!);
                    },
                  ),

                  SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Booking Successful"),
                        ),
                      );
                    },
                    child: Text("Book Now"),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Go Back"),
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
