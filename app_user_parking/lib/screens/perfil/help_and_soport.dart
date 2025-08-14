import 'package:flutter/material.dart';
import 'package:app_user_parking/models/custom_bottom_nav_bar.dart';
import 'quentions_frec.dart';
import 'terms_and_conditions_screen.dart';
import 'privacy_policy_screen.dart';
import 'customer_support_screen.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HelpAndSupportScreenState createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
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
          'Ayuda y Soporte',
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
                _buildHelpItem(
                  icon: Icons.help_outline,
                  title: 'Preguntas Frecuentes',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const FaqScreen()),
                    );
                  },
                ),
                const Divider(height: 0, indent: 16, endIndent: 16),
                _buildHelpItem(
                  icon: Icons.mail_outline,
                  title: 'Contactar a Soporte',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CustomerSupportScreen()),
                    );
                  },
                ),
                const Divider(height: 0, indent: 16, endIndent: 16),
                _buildHelpItem(
                  icon: Icons.description_outlined,
                  title: 'Términos y Condiciones',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TermsAndConditionsScreen()),
                    );
                  },
                ),
                const Divider(height: 0, indent: 16, endIndent: 16),
                _buildHelpItem(
                  icon: Icons.security,
                  title: 'Política de Privacidad',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
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

  Widget _buildHelpItem({
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