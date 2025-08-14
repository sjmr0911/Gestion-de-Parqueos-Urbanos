import 'package:cloud_firestore/cloud_firestore.dart';

// Este es el modelo para guardar la información de una reserva de estacionamiento.
class Reservation {
  // ID único de la reserva. Será el ID del documento en Firestore.
  final String id;
  // ID del estacionamiento al que pertenece la reserva.
  final String parkingId;
  // Nombre del estacionamiento.
  final String parkingName;
  // Hora de inicio de la reserva.
  final DateTime startTime;
  // Hora de fin de la reserva.
  final DateTime endTime;
  // Costo total de la reserva (sin impuestos).
  final double cost;
  // Estado actual de la reserva (ej. 'pending', 'confirmed', 'cancelled').
  final String status;

  // Campos adicionales necesarios para la pantalla de confirmación de pago
  final String title; // Es el mismo que parkingName.
  final String duration; // La duración estimada en un String.
  final double pricePerHour; // El precio por hora del estacionamiento.
  final double subtotal; // Costo total sin impuestos.
  final double taxes; // Impuestos aplicados (calculados).
  final double total; // Total a pagar (subtotal + impuestos).


  // Constructor para crear una nueva instancia de Reservation.
  const Reservation({
    required this.id,
    required this.parkingId,
    required this.parkingName,
    required this.startTime,
    required this.endTime,
    required this.cost,
    required this.status,
    required this.title,
    required this.duration,
    required this.pricePerHour,
    required this.subtotal,
    required this.taxes,
    required this.total,
  });

  // Constructor de fábrica para crear un objeto Reservation desde un documento de Firestore.
  factory Reservation.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Reservation(
      id: doc.id,
      parkingId: data['parkingId'] as String,
      parkingName: data['parkingName'] as String,
      startTime: (data['startTime'] as Timestamp).toDate(),
      endTime: (data['endTime'] as Timestamp).toDate(),
      cost: (data['cost'] as num).toDouble(),
      status: data['status'] as String,
      title: data['title'] as String,
      duration: data['duration'] as String,
      pricePerHour: (data['pricePerHour'] as num).toDouble(),
      subtotal: (data['subtotal'] as num).toDouble(),
      taxes: (data['taxes'] as num).toDouble(),
      total: (data['total'] as num).toDouble(),
    );
  }

  // Método para convertir el objeto Reservation en un mapa, útil para guardar en Firestore.
  Map<String, dynamic> toMap() {
    return {
      'parkingId': parkingId,
      'parkingName': parkingName,
      'startTime': startTime,
      'endTime': endTime,
      'cost': cost,
      'status': status,
      'title': title,
      'duration': duration,
      'pricePerHour': pricePerHour,
      'subtotal': subtotal,
      'taxes': taxes,
      'total': total,
    };
  }
}
