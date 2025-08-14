import 'package:flutter/material.dart';

// Este es un widget reutilizable para la barra de navegación inferior.
// Asegura una apariencia y comportamiento consistentes en todas las pantallas.
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      onTap: (index) {
        // Lógica de navegación centralizada.
        // Usa pushReplacementNamed para una navegación fluida.
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/parking');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/reservations');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/notifications');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/payments');
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
          label: 'Pagos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
      ],
    );
  }
}
