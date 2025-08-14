import 'package:flutter/material.dart';

class ParkingSpot {
  final String id;
  final String location;
  bool isAvailable;

  ParkingSpot({required this.id, required this.location, this.isAvailable = true});
}

class ParkingManager with ChangeNotifier {
  final List<ParkingSpot> _spots = [
    ParkingSpot(id: 'A1', location: 'Zona 1'),
    ParkingSpot(id: 'A2', location: 'Zona 1'),
    ParkingSpot(id: 'B1', location: 'Zona 2'),
  ];

  List<ParkingSpot> get availableSpots => _spots.where((spot) => spot.isAvailable).toList();

  void reserve(String id) {
    final spot = _spots.firstWhere((spot) => spot.id == id);
    spot.isAvailable = false;
    notifyListeners();
  }

  void release(String id) {
    final spot = _spots.firstWhere((spot) => spot.id == id);
    spot.isAvailable = true;
    notifyListeners();
  }

  void addSpot(ParkingSpot spot) {
    _spots.add(spot);
    notifyListeners();
  }

  void removeSpot(String id) {
    _spots.removeWhere((spot) => spot.id == id);
    notifyListeners();
  }
}
