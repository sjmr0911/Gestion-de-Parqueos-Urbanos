import 'package:flutter/material.dart';

class ParkingScreen extends StatelessWidget {
  const ParkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/parking');
              break;
            case 1:
              Navigator.pushNamed(context, '/reserve');
              break;
            case 2:
              Navigator.pushNamed(context, '/notifications');
              break;
            case 3:
              Navigator.pushNamed(context, '/payment');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Mapa"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Reservas"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: "Notificaciones"),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: "Pagos"),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header con mapa simulado y ajustes de visibilidad
            Stack(
              children: [
                SizedBox(
                  height: 130, // Tamaño reducido
                  width: double.infinity,
                  child: Image.network(
                    'https://motor.elpais.com/wp-content/uploads/2022/01/google-maps-22-1046x616.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(217), // 0.85 * 255
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/search');
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Row(
                        children: const [
                          Icon(Icons.location_on_outlined, size: 20),
                          SizedBox(width: 6),
                          Text(
                            'Ubicación Actual',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 16,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(217),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person_outline, size: 24),
                    ),
                  ),
                ),
              ],
            ),

            // Filtros y lista de parqueos
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Estacionamiento Cercano",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            FilterChip(
                              label: const Text("Filtrar"),
                              onSelected: (_) {
                                Navigator.pushNamed(context, '/filter');
                              },
                            ),
                            const SizedBox(width: 8),
                            FilterChip(
                              label: const Text("Ordenar"),
                              onSelected: (_) {
                                Navigator.pushNamed(context, '/sort');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ParkingCard(
                      name: "Estacionamiento Zona Colonial",
                      address: "Av. George Washington, Santo Domingo",
                      price: "RD\$145/h",
                      availabilityText: "5 espacios disponibles",
                      availabilityColor: Colors.green,
                      isFull: false,
                    ),
                    const SizedBox(height: 12),
                    ParkingCard(
                      name: "Estacionamiento El Conde",
                      address: "Calle El Conde, Zona Colonial",
                      price: "RD\$115/h",
                      availabilityText: "12 espacios disponibles",
                      availabilityColor: Colors.green,
                      isFull: false,
                    ),
                    const SizedBox(height: 12),
                    ParkingCard(
                      name: "Estacionamiento Piantini",
                      address: "Av. Winston Churchill, Ens. Piantini",
                      price: "RD\$175/h",
                      availabilityText: "Lleno",
                      availabilityColor: Colors.red,
                      isFull: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ParkingCard extends StatelessWidget {
  final String name;
  final String address;
  final String price;
  final String availabilityText;
  final Color availabilityColor;
  final bool isFull;

  const ParkingCard({
    super.key,
    required this.name,
    required this.address,
    required this.price,
    required this.availabilityText,
    required this.availabilityColor,
    required this.isFull,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
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
                  Text(availabilityText, style: TextStyle(color: availabilityColor, fontWeight: FontWeight.w500)),
                ],
              ),
              ElevatedButton(
                onPressed: isFull
                    ? null
                    : () {
                        Navigator.pushNamed(context, '/reserve');
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFull ? Colors.grey[300] : const Color(0xFF2643FF),
                  foregroundColor: isFull ? Colors.black38 : Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
