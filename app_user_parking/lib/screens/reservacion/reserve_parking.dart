import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/screens/reservacion/reserve_confirmation.dart'; // ✅ Import de pantalla de confirmación

class ReserveParkingScreen extends StatefulWidget {
  final Map<String, dynamic> parkingData;
  final Map<String, String>? paymentMethod;

  const ReserveParkingScreen({
    super.key,
    required this.parkingData,
    this.paymentMethod,
  });

  @override
  State<ReserveParkingScreen> createState() => _ReserveParkingScreenState();
}

class _ReserveParkingScreenState extends State<ReserveParkingScreen> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    final parking = widget.parkingData;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          "Reservar Estacionamiento",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: parking.isEmpty
          ? const Center(child: Text("No se encontró el estacionamiento."))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Mapa de ubicación
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SizedBox(
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              parking["latitude"] ?? 18.4861,
                              parking["longitude"] ?? -69.9312,
                            ),
                            zoom: 15,
                          ),
                          markers: {
                            Marker(
                              markerId: const MarkerId("parking"),
                              position: LatLng(
                                parking["latitude"] ?? 18.4861,
                                parking["longitude"] ?? -69.9312,
                              ),
                              infoWindow: InfoWindow(
                                title: parking["name"] ?? "Parqueo",
                                snippet: parking["address"] ??
                                    "Dirección no disponible",
                              ),
                            )
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${parking["name"] ?? "Parqueo"}\n${parking["address"] ?? "Dirección no disponible"}",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Seleccionar horario
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Seleccionar Horario",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          _buildDateTimePicker(
                            label: "Inicio",
                            selectedDate: _startDate,
                            onDateSelected: (date) {
                              setState(() => _startDate = date);
                            },
                          ),
                          const SizedBox(height: 12),
                          _buildDateTimePicker(
                            label: "Fin",
                            selectedDate: _endDate,
                            onDateSelected: (date) {
                              setState(() => _endDate = date);
                            },
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Duración estimada: ${_calculateDuration()} horas",
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            "Costo estimado: RD\$${_calculateCost()}",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Método de pago seleccionado
                  if (widget.paymentMethod != null) ...[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.credit_card),
                        title: Text(widget.paymentMethod!['type'] ?? ''),
                        subtitle:
                            Text(widget.paymentMethod!['details'] ?? ''),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Selección de método de pago
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.credit_card),
                          title: const Text("Tarjeta de Crédito/Débito"),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            Navigator.pushNamed(context, '/add-payment');
                          },
                        ),
                        const Divider(height: 0),
                        ListTile(
                          leading: const Icon(Icons.money),
                          title: const Text("Efectivo (al llegar)"),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Botón confirmar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007BFF),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _startDate != null && _endDate != null
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReserveConfirmationScreen(
                                    parkingData: widget.parkingData,
                                    startDate: _startDate!,
                                    endDate: _endDate!,
                                    paymentMethod: widget.paymentMethod,
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: const Text(
                        "Confirmar Reserva",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),

      // Barra inferior
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/map-parking');
              break;
            case 1:
              Navigator.pushNamed(context, '/reservations');
              break;
            case 2:
              Navigator.pushNamed(context, '/notifications');
              break;
            case 3:
              Navigator.pushNamed(context, '/payments');
              break;
            case 4:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Mapa"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border), label: "Reservas"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none), label: "Notificaciones"),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: "Pagos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Perfil"),
        ],
      ),
    );
  }

  Widget _buildDateTimePicker({
    required String label,
    required DateTime? selectedDate,
    required Function(DateTime) onDateSelected,
  }) {
    return InkWell(
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 30)),
        );

        if (!mounted) return;

        TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (!mounted) return;

        if (date != null && time != null) {
          onDateSelected(DateTime(
              date.year, date.month, date.day, time.hour, time.minute));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate == null
                  ? "dd/mm/aaaa --:--"
                  : DateFormat("dd/MM/yyyy HH:mm").format(selectedDate),
              style: const TextStyle(fontSize: 14),
            ),
            const Icon(Icons.calendar_today, size: 18),
          ],
        ),
      ),
    );
  }

  int _calculateDuration() {
    if (_startDate != null && _endDate != null) {
      return _endDate!.difference(_startDate!).inHours;
    }
    return 0;
  }

  double _calculateCost() {
    if (_startDate != null && _endDate != null) {
      final hours = _calculateDuration().toDouble();
      final pricePerHour = (widget.parkingData["price"] ?? 0).toDouble();
      return hours * pricePerHour;
    }
    return 0.0;
  }
}
