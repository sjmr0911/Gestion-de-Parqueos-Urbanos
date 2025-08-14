import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMapScreen extends StatefulWidget {
  const CustomMapScreen({super.key});

  @override
  State<CustomMapScreen> createState() => _CustomMapScreenState();
}

class _CustomMapScreenState extends State<CustomMapScreen> {
  GoogleMapController? mapController;
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    // Asegurarse de que los argumentos son del tipo LatLng y no nulos.
    final LatLng location = ModalRoute.of(context)!.settings.arguments as LatLng;
    
    if (_markers.isEmpty) {
      _markers.add(
        Marker(
          markerId: const MarkerId('searched_location'),
          position: location,
          infoWindow: const InfoWindow(title: 'Ubicación Buscada'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación del Parqueo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: location,
          zoom: 15,
        ),
        markers: _markers,
      ),
    );
  }
}
