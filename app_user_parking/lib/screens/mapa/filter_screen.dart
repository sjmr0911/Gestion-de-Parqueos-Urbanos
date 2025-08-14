import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool availableOnly = true;
  double priceRange = 125;
  double distance = 2.5;
  String selectedType = "Todos";
  List<String> selectedFeatures = [];

  final List<String> parkingTypes = ["Todos", "Cubierto", "Descubierto", "Subterráneo"];
  final List<String> features = ["Carga EV", "Seguridad 24/7", "Acceso para discapacitados"];

  void toggleFeature(String feature) {
    setState(() {
      if (selectedFeatures.contains(feature)) {
        selectedFeatures.remove(feature);
      } else {
        selectedFeatures.add(feature);
      }
    });
  }

  void resetFilters() {
    setState(() {
      availableOnly = true;
      priceRange = 125;
      distance = 2.5;
      selectedType = "Todos";
      selectedFeatures.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/parking');
          },
        ),
        title: const Text(
          'Filtrar',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Disponibilidad", style: TextStyle(fontWeight: FontWeight.bold)),
                Switch(
                  value: availableOnly,
                  activeColor: Colors.blue,
                  onChanged: (val) {
                    setState(() {
                      availableOnly = val;
                    });
                  },
                ),
              ],
            ),
            const Text("Mostrar solo espacios disponibles"),
            const SizedBox(height: 30),

            const Text("Rango de Precios", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text("RD\$50 - RD\$${priceRange.toInt()} por hora", style: const TextStyle(color: Colors.grey)),
            Slider(
              value: priceRange,
              onChanged: (val) => setState(() => priceRange = val),
              min: 50,
              max: 200,
              activeColor: Colors.blue,
              divisions: 30,
            ),

            const SizedBox(height: 20),
            const Text("Tipo de Estacionamiento", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: parkingTypes.map((type) {
                final bool isSelected = selectedType == type;
                return ChoiceChip(
                  label: Text(type),
                  selected: isSelected,
                  selectedColor: Colors.blue.shade100,
                  onSelected: (_) => setState(() => selectedType = type),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),
            const Text("Características", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: features.map((feature) {
                final bool selected = selectedFeatures.contains(feature);
                return FilterChip(
                  label: Text(feature),
                  selected: selected,
                  onSelected: (_) => toggleFeature(feature),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),
            const Text("Distancia", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text("Hasta ${distance.toStringAsFixed(1)} km", style: const TextStyle(color: Colors.grey)),
            Slider(
              value: distance,
              onChanged: (val) => setState(() => distance = val),
              min: 1,
              max: 10,
              divisions: 18,
              activeColor: Colors.blue,
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: resetFilters,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  foregroundColor: Colors.grey,
                  side: const BorderSide(color: Colors.grey),
                ),
                child: const Text("Restablecer"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Aquí puedes aplicar lógica con los filtros si lo deseas
                  Navigator.pushReplacementNamed(context, '/parking');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Aplicar Filtros"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
