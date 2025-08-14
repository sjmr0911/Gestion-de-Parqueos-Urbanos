// Tu código para device_vinc.dart
// (Revisado y con correcciones de navegación)
import 'package:flutter/material.dart';
import 'package:app_user_parking/models/custom_bottom_nav_bar.dart';
//import 'package:app_user_parking/screens/perfil/profile_screen.dart'; // Importa la pantalla de perfil para la navegación

class LinkedDevicesScreen extends StatefulWidget {
  const LinkedDevicesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LinkedDevicesScreenState createState() => _LinkedDevicesScreenState();
}

class _LinkedDevicesScreenState extends State<LinkedDevicesScreen> {
  final List<Map<String, String>> _linkedDevices = [
    {
      'name': 'iPhone 15 Pro',
      'location': 'Santo Domingo, DR',
      'status': 'Activo ahora',
    },
    {
      'name': 'MacBook Air',
      'location': 'Santo Domingo, DR',
      'status': 'Última actividad: 2 horas atrás',
    },
    {
      'name': 'Samsung Galaxy S23',
      'location': 'Santiago, DR',
      'status': 'Última actividad: 3 días atrás',
    },
  ];

  void _unlinkDevice(int index) {
    setState(() {
      _linkedDevices.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dispositivo desvinculado con éxito.')),
    );
  }

  void _onItemTapped(int index) {
    // Lógica de navegación no necesaria en esta pantalla
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(), 
        ),
        title: const Text(
          'Dispositivos Vinculados',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _linkedDevices.length,
              separatorBuilder: (context, index) => const Divider(height: 0, indent: 16, endIndent: 16),
              itemBuilder: (context, index) {
                final device = _linkedDevices[index];
                return ListTile(
                  leading: Icon(
                    device['name']!.contains('iPhone') || device['name']!.contains('Samsung') 
                        ? Icons.smartphone 
                        : Icons.laptop_mac,
                    color: Colors.black,
                  ),
                  title: Text(device['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(device['location']!),
                      Text(device['status']!),
                    ],
                  ),
                  trailing: TextButton(
                    onPressed: () => _unlinkDevice(index),
                    child: const Text('Desvincular', style: TextStyle(color: Colors.red)),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 4,
        onTap: _onItemTapped,
      ),
    );
  }
}