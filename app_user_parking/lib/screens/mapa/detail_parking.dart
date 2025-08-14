import 'package:flutter/material.dart';
import 'package:app_user_parking/models/custom_bottom_nav_bar.dart';

class ParkingDetailsScreen extends StatelessWidget {
  // A mock parking spot ID. In a real app, this would be passed from a previous screen.
  final String parkingId;

  const ParkingDetailsScreen({super.key, required this.parkingId});

  // A method to handle the navigation when a tab is tapped
  void _onItemTapped(BuildContext context, int index) {
    // You would add your navigation logic here, for example:
    // switch(index) {
    //   case 0:
    //     Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen()));
    //     break;
    //   case 1:
    //     Navigator.push(context, MaterialPageRoute(builder: (_) => ReservationsScreen()));
    //     break;
    //   case 2:
    //     Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationsScreen()));
    //     break;
    //   case 3:
    //     Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentScreen()));
    //     break;
    //   case 4:
    //     Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
    //     break;
    // }
  }

  @override
  Widget build(BuildContext context) {
    // Here you would fetch the parking details from Firebase using the parkingId.
    // Example: FirebaseFirestore.instance.collection('parkings').doc(parkingId).get();
    // For now, we'll use a mock data map.
    final Map<String, dynamic> parkingDetails = {
      'name': 'Parqueo Central',
      'address': 'Calle El Conde #123, Santo Domingo',
      'total_spaces': 20,
      'available_spaces': 5,
      'price': 'RD\$ 50/hora',
      'security': '24/7',
      'covered': 'No',
      'imageUrl': 'https://placehold.co/600x400/D3D3D3/000000?text=Parking+Image' // Placeholder image
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Detalles del Parqueo',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Image section
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(parkingDetails['imageUrl']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      parkingDetails['name'],
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    // Parking details section
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _buildDetailItem(Icons.location_on_outlined, 'Dirección', parkingDetails['address']),
                            _buildDetailItem(Icons.local_parking_outlined, 'Espacios Totales', '${parkingDetails['total_spaces']}'),
                            _buildDetailItem(Icons.check_circle_outline, 'Espacios Libres', '${parkingDetails['available_spaces']}'),
                            _buildDetailItem(Icons.attach_money, 'Precio', parkingDetails['price']),
                            _buildDetailItem(Icons.security, 'Seguridad', parkingDetails['security']),
                            _buildDetailItem(Icons.roofing, 'Cubierto', parkingDetails['covered']),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add logic to navigate to the reservation screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Reservar Ahora',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0, // 'Mapa' is the first item (index 0)
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }

  // A reusable widget for displaying a single detail item
  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 12),
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Spacer(),
          Text(value),
        ],
      ),
    );
  }
}
