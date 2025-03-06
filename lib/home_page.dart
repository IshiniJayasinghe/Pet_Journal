import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PetJournal",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.account_circle, size: 30,))  //have to change null to function
        ],
        backgroundColor: Colors.orange,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            DrawerHeader(child: Image.asset('assets/petJournal.jpg')),
            ListTile(leading: const Icon(Icons.home), title: const Text("H O M E  P A G E"),),
            ListTile(leading: const Icon(Icons.person), title: const Text("P R O F I L E"),),
            ListTile(leading: const Icon(Icons.shop), title: const Text("S H O P"),),
            ListTile(leading: const Icon(Icons.notifications), title: const Text("R E M I N D E R S"),),
            ListTile(leading: const Icon(Icons.phone), title: const Text(" E - C H A N N E L I N G"),)

          ],
        )
      ),
    );
  }
}