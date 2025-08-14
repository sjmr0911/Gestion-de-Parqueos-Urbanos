import 'package:flutter/material.dart';
import 'package:app_user_parking/models/custom_bottom_nav_bar.dart';
import 'change_pass.dart';
import 'device_vinc.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _twoFactorEnabled = false;

  void _onItemTapped(int index) {
    // Lógica de navegación de la barra inferior
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
          'Seguridad',
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
            child: Column(
              children: [
                _buildSecurityItem(
                  icon: Icons.vpn_key_outlined,
                  title: 'Cambiar Contraseña',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
                    );
                  },
                ),
                const Divider(height: 0, indent: 16, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.verified_user_outlined, color: Colors.black),
                  title: const Text('Autenticación de Dos Factores'),
                  trailing: Switch(
                    value: _twoFactorEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _twoFactorEnabled = value;
                        // Aquí debes agregar la lógica para habilitar/deshabilitar la autenticación de dos factores en Firebase.
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                const Divider(height: 0, indent: 16, endIndent: 16),
                _buildSecurityItem(
                  icon: Icons.computer_outlined,
                  title: 'Dispositivos Vinculados',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const LinkedDevicesScreen()),
                    );
                  },
                ),
              ],
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

  Widget _buildSecurityItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onTap,
    );
  }
}