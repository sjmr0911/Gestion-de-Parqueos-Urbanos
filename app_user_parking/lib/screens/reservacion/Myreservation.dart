import 'package:flutter/material.dart';
import 'package:app_user_parking/models/custom_bottom_nav_bar.dart';

class MyReservationsScreen extends StatelessWidget {
  const MyReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // 🔹 Se eliminó el botón de "menor que" (back)
        title: const Text(
          'Mis Reservas',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              // Acción al presionar el +
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Reservas Activas
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Reservas Activas',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            _buildReservationCard(
              title: 'Parqueo Central',
              subtitle: 'Hoy, 10:00 AM - 12:00 PM',
              status: 'Confirmada',
              statusColor: Colors.green,
              buttonText: 'Ver QR',
            ),
            _buildReservationCard(
              title: 'Parqueo El Sol',
              subtitle: 'Mañana, 09:00 AM - 11:00 AM',
              status: 'Pendiente',
              statusColor: Colors.orange,
              buttonText: 'Modificar',
            ),

            // 🔹 Historial de Reservas
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Historial de Reservas',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            _buildReservationCard(
              title: 'Parqueo La Esquina',
              subtitle: 'Ayer, 03:00 PM - 05:00 PM',
              status: 'Completada',
              statusColor: Colors.grey,
              buttonText: 'Ver Detalles',
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1, // Índice de "Reservas"
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/parking');
              break;
            case 1:
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/notifications');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/payment');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }

  Widget _buildReservationCard({
    required String title,
    required String subtitle,
    required String status,
    required Color statusColor,
    required String buttonText,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Info reserva
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            // Estado y botón
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(status,
                    style: TextStyle(
                        color: statusColor, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue[100],
                      padding: const EdgeInsets.symmetric(horizontal: 12)),
                  onPressed: () {},
                  child: Text(buttonText,
                      style: const TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
