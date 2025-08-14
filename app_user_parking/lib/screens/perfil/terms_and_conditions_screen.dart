import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  // ✅ Se agrega el constructor con `key` para seguir las buenas prácticas.
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Términos y Condiciones'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido a nuestra aplicación de gestión de estacionamiento. Al utilizar nuestros servicios, usted acepta los siguientes términos y condiciones:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            _buildSection(
              title: '1. Aceptación de los Términos',
              content: 'Al acceder o utilizar nuestra aplicación, usted reconoce que ha leído, entendido y aceptado estar sujeto a estos Términos y Condiciones, así como a nuestra Política de Privacidad.',
            ),
            _buildSection(
              title: '2. Uso del Servicio',
              content: 'Usted es responsable de mantener la confidencialidad de su cuenta y contraseña.\n\nDebe proporcionar información precisa y completa al registrarse y al realizar reservas.\n\nEl uso de la aplicación es solo para fines personales y no comerciales.',
              isList: true,
            ),
            _buildSection(
              title: '3. Reservas y Pagos',
              content: 'Todas las reservas están sujetas a disponibilidad.\n\nLos precios de estacionamiento se muestran en la aplicación y pueden variar.\n\nLos pagos se procesan a través de métodos de pago seguros.\n\nLas cancelaciones y reembolsos están sujetos a nuestra política de cancelación.',
              isList: true,
            ),
            _buildSection(
              title: '4. Conducta del Usuario',
              content: 'Usted se compromete a no:\n\nUtilizar la aplicación para fines ilegales o no autorizados.\n\nInterferir con la seguridad o el funcionamiento de la aplicación.\n\nInfringir los derechos de propiedad de terceros.',
              isList: true,
            ),
            _buildSection(
              title: '5. Limitación de Responsabilidad',
              content: 'La aplicación se proporciona "tal cual" y "según disponibilidad". No garantizamos que la aplicación esté libre de errores. No seremos responsables de ningún daño directo, indirecto, incidental o consecuente que surja del uso o la imposibilidad de usar la aplicación.',
            ),
            _buildSection(
              title: '6. Modificaciones de los Términos',
              content: 'Nos reservamos el derecho de modificar estos Términos y Condiciones en cualquier momento. Las modificaciones entrarán en vigor inmediatamente después de su publicación. Su uso continuado de la aplicación después de dichas modificaciones constituye su aceptación de los nuevos términos.',
            ),
            _buildSection(
              title: '7. Ley Aplicable',
              content: 'Estos Términos y Condiciones se regirán e interpretarán de acuerdo con las leyes de la República Dominicana.',
            ),
            _buildSection(
              title: 'Contacto',
              content: 'Si tiene alguna pregunta sobre estos Términos y Condiciones, por favor contáctenos a través de la sección de soporte de la aplicación.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content, bool isList = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          SizedBox(height: 8.0),
          if (isList)
            // ✅ Se eliminó `.toList()` ya que el operador de propagación lo hace innecesario.
            ...content.split('\n\n').map((item) => _buildBulletPoint(item))
          else
            Text(
              content,
              style: TextStyle(fontSize: 16.0),
            ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 16.0)),
          Expanded(
            child: Text(text.trim(), style: TextStyle(fontSize: 16.0)),
          ),
        ],
      ),
    );
  }
}