import 'package:flutter/material.dart';

class CustomerSupportScreen extends StatelessWidget {
  // ✅ Constructor corregido para incluir el parámetro `key`
  const CustomerSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soporte al Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Asunto',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Ingrese el asunto',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Mensaje',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Describa su problema o consulta',
                border: OutlineInputBorder(),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Lógica para enviar el mensaje
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              // ✅ `child` se movió al final de los argumentos
              child: Text('Enviar Mensaje'),
            ),
          ],
        ),
      ),
    );
  }
}