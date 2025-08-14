// File: parking_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

// This class represents a parking spot from your Firebase backend.
// It's a data model used to structure and handle parking spot data.
class Parking {
  final String id;
  final String title;
  final String address;
  final double latitude;
  final double longitude;
  final double pricePerHour;

  Parking({
    required this.id,
    required this.title,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.pricePerHour,
  });

  // Factory method to create a Parking object from a Firestore document.
  // It handles potential null or missing data fields gracefully.
  factory Parking.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Parking(
      id: doc.id,
      title: data['title'] ?? 'Parqueo Desconocido',
      address: data['address'] ?? 'Dirección Desconocida',
      latitude: data['latitude'] ?? 0.0,
      longitude: data['longitude'] ?? 0.0,
      pricePerHour: data['price_per_hour'] ?? 0.0,
    );
  }
}
