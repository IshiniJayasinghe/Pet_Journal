import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _navigateToProfile(){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>null/*ProfilePage()*/));
  }
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ExplorePage(),
    const SavedPage(),
    const UpdatesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PetJournal",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: _navigateToProfile, icon: Icon(Icons.account_circle, size: 30,))  //have to change null to function
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
      body: Stack(
        children: [
          // Background Logo
          Positioned.fill(
            child: Opacity(
              opacity: 0.1, // Adjust opacity for subtle effect
              child: Image.asset(
                'assets/petJournal.jpg', // Your background logo
                fit: BoxFit.cover, // Cover entire background
              ),
            ),
          ),

          // Buttons
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
              CustomButton(label: "Pet Records", onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PetRecordsPage()))),
              CustomButton(label: "E-Channeling",onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EChannelling()))),
              CustomButton(label: "Reminders",onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Reminders()))),
              CustomButton(label: "PetShop",onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PetShop()))),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: "Saved",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: "Updates",
          ),

        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
