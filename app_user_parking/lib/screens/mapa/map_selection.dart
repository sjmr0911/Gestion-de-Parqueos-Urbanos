import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // ¡Línea corregida!

class MapSelectionScreen extends StatefulWidget {
  const MapSelectionScreen({super.key});

  @override
  State<MapSelectionScreen> createState() => _MapSelectionScreenState();
}

class _MapSelectionScreenState extends State<MapSelectionScreen> {
  GoogleMapController? mapController;
  LatLng? selectedLocation;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    setState(() {
      selectedLocation = position.target;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seleccionar Ubicación"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Regresa la ubicación seleccionada a la pantalla anterior
            Navigator.pop(context, selectedLocation);
          },
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(18.486057, -69.930777), // Coordenadas de Santo Domingo
              zoom: 15,
            ),
            onCameraMove: onCameraMove,
          ),
          const Center(
            child: Icon(Icons.location_on, color: Colors.blue, size: 40),
          ),
        ],
      ),
    );
  }
}
