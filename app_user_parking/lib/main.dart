import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

// Modelos y providers
import 'models/provider.dart';
import 'models/parking_provider.dart';
import 'models/reservation.dart';

// Login
import 'screens/login/login.dart';
import 'screens/login/register.dart';

// Mapa
import 'screens/mapa/detail_parking.dart';
import 'screens/mapa/filter_screen.dart';
import 'screens/mapa/map_parking.dart';
import 'screens/mapa/map_selection.dart';
import 'screens/mapa/search_location.dart';
import 'screens/mapa/sort_screen.dart';

// Notificaciones
import 'screens/notificacion/Mynotification.dart';

// Pagos
import 'screens/pagos/add_payment.dart';
import 'screens/pagos/confirmation_page.dart';
import 'screens/pagos/payment_methods.dart';

// Perfil
import 'screens/perfil/change_pass.dart';
import 'screens/perfil/device_vinc.dart';
import 'screens/perfil/edit_profile.dart';
import 'screens/perfil/help_and_soport.dart';
import 'screens/perfil/profile_screen.dart';
import 'screens/perfil/quentions_frec.dart';
import 'screens/perfil/security_profile.dart';

// Reservaciones
import 'screens/reservacion/Myreservation.dart';
import 'screens/reservacion/reserve_confirmation.dart';
import 'screens/reservacion/reserve_parking.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ParkingProvider()),
        ChangeNotifierProvider(create: (context) => ParkingManager()),
      ],
      child: const ParkingApp(),
    ),
  );
}

class ParkingApp extends StatelessWidget {
  const ParkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/reserve-parking':
            final parkingData = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (context) => parkingData != null
                  ? ReserveParkingScreen(parkingData: parkingData)
                  : const MapParkingScreen(),
            );

          case '/detail-parking':
            final parkingId = settings.arguments as String?;
            return MaterialPageRoute(
              builder: (context) => parkingId != null
                  ? ParkingDetailsScreen(parkingId: parkingId)
                  : const MapParkingScreen(),
            );

          case '/payment-confirmation':
            final reservation = settings.arguments as Reservation?;
            return MaterialPageRoute(
              builder: (context) => reservation != null
                  ? PaymentConfirmationScreen()
                  : const MapParkingScreen(),
            );

          case '/reserve-confirmation':
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (context) => args != null
                  ? ReserveConfirmationScreen(
                      parkingData: args["parkingData"] as Map<String, dynamic>,
                      startDate: args["startDate"] as DateTime,
                      endDate: args["endDate"] as DateTime,
                      paymentMethod:
                          args["paymentMethod"] as Map<String, String>?,
                    )
                  : const MapParkingScreen(),
            );

          case '/login':
            return MaterialPageRoute(builder: (context) => const Login());
          case '/register':
            return MaterialPageRoute(
                builder: (context) => const RegisterScreen());
          case '/map-parking':
            return MaterialPageRoute(
                builder: (context) => const MapParkingScreen());
          case '/reservations':
            return MaterialPageRoute(
                builder: (context) => const MyReservationsScreen());
          case '/notifications':
            return MaterialPageRoute(
                builder: (context) => const NotificationsScreen());
          case '/payments':
            return MaterialPageRoute(
                builder: (context) => const PaymentMethodsScreen());
          case '/profile':
            return MaterialPageRoute(
                builder: (context) => const ProfileScreen());
          case '/filter':
            return MaterialPageRoute(
                builder: (context) => const FilterScreen());
          case '/map-selection':
            return MaterialPageRoute(
                builder: (context) => const MapSelectionScreen());
          case '/search-location':
            return MaterialPageRoute(
                builder: (context) => const SearchLocationScreen());
          case '/sort':
            return MaterialPageRoute(
                builder: (context) => const SortScreen());
          case '/add-payment':
            return MaterialPageRoute(
                builder: (context) => const AddPaymentMethodScreen());
          case '/change-pass':
            return MaterialPageRoute(
                builder: (context) => const ChangePasswordScreen());
          case '/device-vinc':
            return MaterialPageRoute(
                builder: (context) => const LinkedDevicesScreen());
          case '/edit-profile':
            return MaterialPageRoute(
                builder: (context) => const EditProfileScreen());
          case '/help-support':
            return MaterialPageRoute(
                builder: (context) => const HelpAndSupportScreen());
          case '/security-profile':
            return MaterialPageRoute(
                builder: (context) => const SecurityScreen());
          case '/frequent-questions':
            return MaterialPageRoute(builder: (context) => const FaqScreen());
          default:
            return MaterialPageRoute(
                builder: (context) => const MapParkingScreen());
        }
      },
    );
  }
}
