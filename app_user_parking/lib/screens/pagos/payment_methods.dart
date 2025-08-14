import 'package:flutter/material.dart';
import 'add_payment.dart';
import 'edit_payment.dart';

// Esta pantalla ahora es un StatefulWidget para gestionar la lista de pagos
class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  // Se declara como 'final' ya que la lista en sí no se reasigna
  final List<Map<String, String>> _paymentMethods = [
    {'type': 'Tarjeta de Crédito/Débito', 'details': '**** **** **** 1234'},
    {'type': 'Billetera Digital', 'details': 'PayPal'},
  ];

  // Widget para la barra de navegación inferior
  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      currentIndex: 3, // 'Pago' es el cuarto elemento (índice 3)
      onTap: (index) {
        // Redireccionar según el índice seleccionado
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/parking');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/reserve');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/notifications');
            break;
          case 3:
            break;
          case 4:
            Navigator.pushReplacementNamed(context, '/profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          label: 'Mapa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border),
          label: 'Reservas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none),
          label: 'Notificaciones',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card),
          label: 'Pago',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
      ],
    );
  }

  // Navega a la pantalla de edición y actualiza la lista al volver
  void _editPaymentMethod(int index) async {
    // Almacena el BuildContext en una variable local antes del 'await'
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final updatedMethod = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPaymentScreen(
          paymentMethod: _paymentMethods[index],
        ),
      ),
    );

    // Se verifica si el widget sigue montado después de la operación asíncrona
    if (!mounted) return;

    if (updatedMethod != null) {
      if (updatedMethod['action'] == 'deleted') {
        setState(() {
          _paymentMethods.removeAt(index);
        });
        // Usa el contexto almacenado
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Método de pago eliminado.')),
        );
      } else {
        setState(() {
          _paymentMethods[index] = {
            'type': updatedMethod['type'] as String,
            'details': updatedMethod['details'] as String,
          };
        });
        // Usa el contexto almacenado
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Método de pago actualizado.')),
        );
      }
    }
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
          'Pagos',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Métodos de Pago',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Lista de métodos de pago
              ..._paymentMethods.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, String> method = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: ListTile(
                      leading: Icon(
                        method['type'] == 'Billetera Digital'
                            ? Icons.account_balance_wallet_outlined
                            : Icons.credit_card,
                      ),
                      title: Text(method['type']!),
                      subtitle: Text(method['details']!),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Al hacer clic, navega a la pantalla de edición
                        _editPaymentMethod(index);
                      },
                    ),
                  ),
                );
              }),

              const SizedBox(height: 24),

              // Botón para añadir nuevo método de pago
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    // Almacena el BuildContext en una variable local antes del 'await'
                    final scaffoldMessenger = ScaffoldMessenger.of(context);
                    // Navega a la pantalla de añadir pago y espera el resultado
                    final newPayment = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddPaymentMethodScreen(),
                      ),
                    );

                    // Se verifica si el widget sigue montado después de la operación asíncrona
                    if (!mounted) return;

                    if (newPayment != null) {
                      setState(() {
                        _paymentMethods.add(newPayment as Map<String, String>);
                      });
                      // Usa el contexto almacenado
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(content: Text('Nuevo método de pago agregado.')),
                      );
                    }
                  },
                  icon: const Icon(Icons.add_circle_outline, color: Colors.blue),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Añadir nuevo método de pago',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.blue.withValues(),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }
}