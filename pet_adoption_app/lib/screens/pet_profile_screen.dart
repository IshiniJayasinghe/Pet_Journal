import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/pet.dart';
import '../services/firebase_service.dart';

class PetProfileScreen extends StatelessWidget {
  final Pet pet;
  final FirebaseService _firebaseService = FirebaseService();

  PetProfileScreen({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pet Profile'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            // Pet image
            CircleAvatar(
              radius: 80,
              backgroundImage: CachedNetworkImageProvider(pet.imageUrl),
            ),
            const SizedBox(height: 16),

            // Pet name and breed
            Text(
              pet.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              pet.breed,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),

            // Pet details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Age ${pet.age} year, ${pet.gender}, ${pet.isSpayed ? 'Spayed' : 'Not Spayed'}',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),

            // Vaccinations section
            _buildSectionHeader('Vaccinations & Medications'),
            _buildInfoRow('Next Vaccination', pet.nextVaccination),
            _buildInfoRow('Flea Meds Due', pet.fleaMedsDue),
            _buildInfoRow('Heartworm Meds Due', pet.heartwormMedsDue),

            // Health section
            _buildSectionHeader('Health & Wellness'),
            _buildInfoRow('Weight', '${pet.weight} lbs'),
            _buildInfoRow('Feeding Schedule', pet.feedingSchedule),
            _buildInfoRow('Activity', pet.activity),

            // Vet visits section
            _buildSectionHeader('Vet Visits'),
            ...pet.vetVisits
                .map(
                  (visit) => _buildVetVisitRow(
                    visit['year'].toString(),
                    visit['type'],
                    onTap: () {
                      // Show vet visit details
                    },
                  ),
                )
                .toList(),

            // Add event button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showAddEventDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Add Event'),
                ),
              ),
            ),
          ],
        ),
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

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildVetVisitRow(
    String year,
    String type, {
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                year,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                type,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
          IconButton(icon: const Icon(Icons.arrow_forward), onPressed: onTap),
        ],
      ),
    );
  }

  void _showAddEventDialog(BuildContext context) {
    String eventType = 'Vet Visit';
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add New Event'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: eventType,
                  decoration: const InputDecoration(labelText: 'Event Type'),
                  items:
                      ['Vet Visit', 'Vaccination', 'Medication', 'Grooming']
                          .map(
                            (type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    eventType = value!;
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      selectedDate = picked;
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    child: Text(
                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add the event
                  _firebaseService.addVetVisit(pet.id, {
                    'year': selectedDate.year,
                    'type': eventType,
                    'date': selectedDate.toIso8601String(),
                  });
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }
}
