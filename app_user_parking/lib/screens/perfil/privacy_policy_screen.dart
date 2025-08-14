import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  // ✅ Constructor corregido para incluir el parámetro `key`
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Política de Privacidad'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Esta Política de Privacidad describe cómo se recopila, utiliza y comparte su información personal cuando visita o realiza una compra en nuestra aplicación móvil.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Información que Recopilamos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Cuando utiliza nuestra aplicación, podemos recopilar cierta información sobre usted, incluyendo su nombre, dirección de correo electrónico, número de teléfono, información de ubicación (si lo permite) y detalles de las transacciones de estacionamiento.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Cómo Usamos su Información',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildListItem('Proveer y mantener el servicio de gestión de estacionamiento.'),
                _buildListItem('Procesar sus reservas y pagos.'),
                _buildListItem('Mejorar y personalizar su experiencia en la aplicación.'),
                _buildListItem('Comunicarnos con usted sobre su cuenta, reservas y actualizaciones del servicio.'),
                _buildListItem('Detectar, prevenir y abordar problemas técnicos o de seguridad.'),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Compartir su Información',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'No compartimos su información personal con terceros, excepto cuando sea necesario para operar el servicio (por ejemplo, con procesadores de pago) o cuando lo exija la ley.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Seguridad de los Datos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Implementamos medidas de seguridad razonables para proteger su información personal contra el acceso no autorizado, la alteración, la divulgación o la destrucción.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Sus Derechos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Usted tiene derecho a acceder, corregir o eliminar su información personal. Para ejercer estos derechos, por favor contáctenos a través de la sección de soporte de la aplicación.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Cambios a Esta Política',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Podemos actualizar nuestra Política de Privacidad de vez en cuando. Le notificaremos cualquier cambio publicando la nueva Política de Privacidad en esta página.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Contacto',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Si tiene alguna pregunta sobre estos Términos y Condiciones, por favor contáctenos.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 16.0)),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 16.0)),
          ),
        ],
      ),
    );
  }
}