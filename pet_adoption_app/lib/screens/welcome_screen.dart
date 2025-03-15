import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../services/firebase_service.dart';
import '../widgets/pet_card.dart';
import '../widgets/category_button.dart';
import 'pet_profile_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  String _selectedCategory = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Implement drawer or menu functionality
          },
        ),
        actions: [
          CircleAvatar(
            backgroundImage: const NetworkImage(
              'https://fastly.picsum.photos/id/40/4106/2806.jpg?hmac=MY3ra98ut044LaWPEKwZowgydHZ_rZZUuOHrc3mL5mI',
            ), // Replace with user image
            radius: 16,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.mic),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                CategoryButton(
                  icon: Image.asset(
                    'assets/images/dogicon.png',
                    width: 40,
                    height: 40,
                  ),
                  label: 'Dogs',
                  isSelected: _selectedCategory == 'dogs',
                  onTap: () => setState(() => _selectedCategory = 'dogs'),
                  color: Colors.orange,
                ),
                CategoryButton(
                  icon: Image.asset(
                    'assets/images/caticon.png',
                    width: 40,
                    height: 40,
                  ),
                  label: 'Cats',
                  isSelected: _selectedCategory == 'cats',
                  onTap: () => setState(() => _selectedCategory = 'cats'),
                ),
                CategoryButton(
                  icon: Image.asset(
                    'assets/images/fishicon.png',
                    width: 40,
                    height: 40,
                  ),
                  label: 'Fishes',
                  isSelected: _selectedCategory == 'fishes',
                  onTap: () => setState(() => _selectedCategory = 'fishes'),
                ),
                CategoryButton(
                  icon: Image.asset(
                    'assets/images/parroticon.png',
                    width: 40,
                    height: 40,
                  ),
                  label: 'Parrots',
                  isSelected: _selectedCategory == 'parrots',
                  onTap: () => setState(() => _selectedCategory = 'parrots'),
                ),
                CategoryButton(
                  icon: Image.asset(
                    'assets/images/rabbit.png',
                    width: 40,
                    height: 40,
                  ),
                  label: 'Bunnies',
                  isSelected: _selectedCategory == 'bunnies',
                  onTap: () => setState(() => _selectedCategory = 'bunnies'),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Pet>>(
              stream:
                  _selectedCategory == 'all'
                      ? _firebaseService.getPets()
                      : _firebaseService.getPetsByCategory(_selectedCategory),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No pets available'));
                }
                final pets = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    final pet = pets[index];
                    return PetCard(
                      pet: pet,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PetProfileScreen(pet: pet),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Pets'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
