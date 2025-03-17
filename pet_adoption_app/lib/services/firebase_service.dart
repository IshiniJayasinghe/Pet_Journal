import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pet.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all pets
  Stream<List<Pet>> getPets() {
    return _firestore.collection('pets').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        try {
          var data = doc.data();
          print('Processing document: ${doc.id}');
          return Pet.fromMap(data, doc.id);
        } catch (e) {
          print('Error converting document ${doc.id}: $e');
          // You can either skip this document or return a default Pet
          return Pet(
            id: doc.id,
            name: 'Error loading pet',
            breed: 'Unknown',
            imageUrl: 'https://via.placeholder.com/150',
            age: 0,
            gender: 'Unknown',
            isSpayed: false,
            nextVaccination: '',
            fleaMedsDue: '',
            heartwormMedsDue: '',
            weight: 0,
            feedingSchedule: '',
            activity: '',
            vetVisits: [],
            price: 0,
            description: 'There was an error loading this pet',
          );
        }
      }).toList();
    });
  }

  // Get pets by category (dogs, cats, etc.)
  Stream<List<Pet>> getPetsByCategory(String category) {
    return _firestore
        .collection('pets')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Pet.fromMap(doc.data(), doc.id);
          }).toList();
        });
  }

  // Get a specific pet by ID
  Future<Pet?> getPetById(String petId) async {
    final doc = await _firestore.collection('pets').doc(petId).get();
    if (doc.exists) {
      return Pet.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  // Add a new pet
  Future<void> addPet(Pet pet) {
    return _firestore.collection('pets').add(pet.toMap());
  }

  // Add a vet visit to a pet
  Future<void> addVetVisit(String petId, Map<String, dynamic> visit) {
    return _firestore.collection('pets').doc(petId).update({
      'vetVisits': FieldValue.arrayUnion([visit]),
    });
  }
}
