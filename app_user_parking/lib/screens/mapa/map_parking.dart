import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app_user_parking/screens/reservacion/Myreservation.dart';
import 'package:app_user_parking/screens/notificacion/Mynotification.dart';
import 'package:app_user_parking/screens/pagos/payment_methods.dart';
import 'package:app_user_parking/screens/perfil/profile_screen.dart';
import 'package:app_user_parking/screens/reservacion/reserve_parking.dart';

class ParkingCard extends StatelessWidget {
  final String name;
  final String address;
  final String price;
  final String availabilityText;
  final Color availabilityColor;
  final bool isFull;
  final Map<String, dynamic> parkingData;
  final VoidCallback onReserve;

  const ParkingCard({
    super.key,
    required this.name,
    required this.address,
    required this.price,
    required this.availabilityText,
    required this.availabilityColor,
    required this.isFull,
    required this.parkingData,
    required this.onReserve,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(price,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 4),
          Text(address, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.circle, size: 12, color: availabilityColor),
                  const SizedBox(width: 6),
                  Text(
                    availabilityText,
                    style: TextStyle(
                        color: availabilityColor,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: isFull ? null : onReserve,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isFull ? Colors.grey[300] : const Color(0xFF2643FF),
                  foregroundColor: isFull ? Colors.black38 : Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 8),
                ),
                child: Text(isFull ? 'Lleno' : 'Reservar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MapParkingScreen extends StatefulWidget {
  const MapParkingScreen({super.key});

  @override
  State<MapParkingScreen> createState() => _MapParkingScreenState();
}

class _MapParkingScreenState extends State<MapParkingScreen> {
  final String _currentLocation = 'Ubicación Actual';
  final LatLng _initialLocation = const LatLng(18.4719, -69.9324);
  List<Map<String, dynamic>> _parkingSpots = [];
  Set<Marker> _markers = {};
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadStaticParkingSpots();
  }

  void _loadStaticParkingSpots() {
    _parkingSpots = [
      {
        "id": "p1",
        "name": "Estacionamiento Colonial",
        "address": "Calle El Conde #45, Zona Colonial",
        "price": 120.0,
        "availableSpots": 5,
        "lat": 18.4721,
        "lng": -69.8824,
      },
      {
        "id": "p2",
        "name": "Parqueo Malecon",
        "address": "Av. George Washington, Santo Domingo",
        "price": 150.0,
        "availableSpots": 0,
        "lat": 18.4710,
        "lng": -69.8901,
      },
      {
        "id": "p3",
        "name": "Estacionamiento Piantini",
        "address": "Av. Abraham Lincoln #890, Piantini",
        "price": 200.0,
        "availableSpots": 8,
        "lat": 18.4705,
        "lng": -69.9302,
      },
    ];

    _updateMarkers();
  }

  void _updateMarkers() {
    setState(() {
      _markers = _parkingSpots.map((spot) {
        return Marker(
          markerId: MarkerId(spot["id"]),
          position: LatLng(spot["lat"], spot["lng"]),
          infoWindow: InfoWindow(
            title: spot["name"],
            snippet: spot["address"],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReserveParkingScreen(parkingData: spot),
                ),
              );
            },
          ),
        );
      }).toSet();
    });
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MyReservationsScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NotificationsScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PaymentMethodsScreen()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: _initialLocation, zoom: 14.0),
            markers: _markers,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
          ),
          Positioned(
            left: 16,
            right: 16,
            top: 50,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined,
                      color: Colors.grey, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _currentLocation,
                      style: const TextStyle(
                          fontSize: 16, color: Colors.black54),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.search, color: Colors.black, size: 20),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.15,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _parkingSpots.length,
                  itemBuilder: (context, index) {
                    final spot = _parkingSpots[index];
                    final isFull = spot["availableSpots"] == 0;
                    final availabilityText = isFull
                        ? "Lleno"
                        : "${spot["availableSpots"]} espacios disponibles";
                    final availabilityColor =
                        isFull ? Colors.red : Colors.green;

                    return ParkingCard(
                      name: spot["name"],
                      address: spot["address"],
                      price: "RD\$${spot["price"]}/h",
                      availabilityText: availabilityText,
                      availabilityColor: availabilityColor,
                      isFull: isFull,
                      parkingData: spot,
                      onReserve: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReserveParkingScreen(parkingData: spot),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF2643FF),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Reservas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notificaciones'),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card), label: 'Pago'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
