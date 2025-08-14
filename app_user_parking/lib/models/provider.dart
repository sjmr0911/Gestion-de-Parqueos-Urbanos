import 'package:flutter/material.dart';

class ParkingProvider with ChangeNotifier {
  // ---------------------------
  // Usuario (sesión de login)
  // ---------------------------
  String _userName = '';
  String _userEmail = '';

  String get userName => _userName;
  String get userEmail => _userEmail;

  void login(String name, String email) {
    _userName = name;
    _userEmail = email;
    notifyListeners();
  }

  void logout() {
    _userName = '';
    _userEmail = '';
    notifyListeners();
  }

  // ---------------------------
  // Reservas de parqueo
  // ---------------------------
  String _selectedSpot = '';
  bool _isReserved = false;
  DateTime? _reservationTime;

  String get selectedSpot => _selectedSpot;
  bool get isReserved => _isReserved;
  DateTime? get reservationTime => _reservationTime;

  void reserveSpot(String spotId) {
    _selectedSpot = spotId;
    _isReserved = true;
    _reservationTime = DateTime.now();
    notifyListeners();
  }

  void cancelReservation() {
    _selectedSpot = '';
    _isReserved = false;
    _reservationTime = null;
    notifyListeners();
  }
}

