import 'dart:convert';

class Pet {
  final String id;
  final String name;
  final String breed;
  final String imageUrl;
  final int age;
  final String gender;
  final bool isSpayed;
  final String nextVaccination;
  final String fleaMedsDue;
  final String heartwormMedsDue;
  final int weight;
  final String feedingSchedule;
  final String activity;
  final List<Map<String, dynamic>> vetVisits;
  final int price;
  final String description;

  Pet({
    required this.id,
    required this.name,
    required this.breed,
    required this.imageUrl,
    required this.age,
    required this.gender,
    required this.isSpayed,
    required this.nextVaccination,
    required this.fleaMedsDue,
    required this.heartwormMedsDue,
    required this.weight,
    required this.feedingSchedule,
    required this.activity,
    required this.vetVisits,
    required this.price,
    required this.description,
  });

  factory Pet.fromMap(Map<String, dynamic> map, String id) {
    // Handle vetVisits properly
    List<Map<String, dynamic>> vetVisits = [];
    var vetVisitsData = map['vetVisits'];

    if (vetVisitsData != null) {
      if (vetVisitsData is List) {
        // If it's already a List, map each item ensuring it's a Map
        vetVisits = List<Map<String, dynamic>>.from(
          vetVisitsData.map((visit) {
            if (visit is Map) {
              return Map<String, dynamic>.from(visit);
            } else {
              print('Invalid vet visit data: $visit');
              return <String, dynamic>{};
            }
          }),
        );
      } else if (vetVisitsData is String) {
        // If it's a String (possibly JSON), try to parse it
        try {
          var decoded = jsonDecode(vetVisitsData);
          if (decoded is List) {
            vetVisits = List<Map<String, dynamic>>.from(
              decoded.map(
                (v) =>
                    v is Map
                        ? Map<String, dynamic>.from(v)
                        : <String, dynamic>{},
              ),
            );
          }
        } catch (e) {
          print('Error parsing vetVisits: $e');
        }
      }
    }

    return Pet(
      id: id,
      name: map['name'] ?? '',
      breed: map['breed'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      age: map['age'] ?? 0,
      gender: map['gender'] ?? '',
      isSpayed: map['isSpayed'] ?? false,
      nextVaccination: map['nextVaccination'] ?? '',
      fleaMedsDue: map['fleaMedsDue'] ?? '',
      heartwormMedsDue: map['heartwormMedsDue'] ?? '',
      weight: map['weight'] ?? 0,
      feedingSchedule: map['feedingSchedule'] ?? '',
      activity: map['activity'] ?? '',
      vetVisits: vetVisits,
      price: map['price'] ?? 0,
      description: map['description'] ?? 'Lorem ipsum is simply dummy',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'breed': breed,
      'imageUrl': imageUrl,
      'age': age,
      'gender': gender,
      'isSpayed': isSpayed,
      'nextVaccination': nextVaccination,
      'fleaMedsDue': fleaMedsDue,
      'heartwormMedsDue': heartwormMedsDue,
      'weight': weight,
      'feedingSchedule': feedingSchedule,
      'activity': activity,
      'vetVisits': vetVisits,
      'price': price,
      'description': description,
    };
  }
}
