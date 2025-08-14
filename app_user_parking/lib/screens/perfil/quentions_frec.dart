import 'package:flutter/material.dart';
import 'package:app_user_parking/models/custom_bottom_nav_bar.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  // A method to handle the navigation when a tab is tapped
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
          'Preguntas Frecuentes',
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
            child: const Column(
              children: [
                _FaqItem(
                  '¿Cómo encuentro un estacionamiento disponible?',
                  'Puedes usar la vista de mapa o la lista para ver la disponibilidad de estacionamientos en tiempo real. Los espacios disponibles se muestran en verde.',
                ),
                Divider(height: 0),
                _FaqItem(
                  '¿Cómo hago una reserva?',
                  'Selecciona el estacionamiento deseado en el mapa o la lista, elige el tiempo de reserva y confirma. Recibirás un código QR para acceder.',
                ),
                Divider(height: 0),
                _FaqItem(
                  '¿Qué métodos de pago aceptan?',
                  'Aceptamos tarjetas de crédito/débito, pagos móviles y efectivo en pesos dominicanos (DOP) en ubicaciones seleccionadas.',
                ),
                Divider(height: 0),
                _FaqItem(
                  '¿Puedo cancelar o modificar mi reserva?',
                  'Sí, puedes cancelar o modificar tu reserva a través de la sección "Reservas" en la aplicación, sujeto a nuestra política de cancelación.',
                ),
                Divider(height: 0),
                _FaqItem(
                  '¿Cómo obtengo direcciones al estacionamiento?',
                  'Una vez que reserves, la aplicación te proporcionará direcciones detalladas a través de tu aplicación de mapas preferida.',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 4, // 'Perfil' is the fifth item (index 4)
        onTap: _onItemTapped,
      ),
    );
  }
}

// A reusable FAQ item using ExpansionTile
class _FaqItem extends StatelessWidget {
  const _FaqItem(this.question, this.answer);

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(answer),
        ),
      ],
    );
  }
}