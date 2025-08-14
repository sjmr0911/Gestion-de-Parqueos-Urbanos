import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Se ha corregido la importación para apuntar a la clase de proveedor correcta
import 'package:app_user_parking/models/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailErrorText; 
  String? _passwordErrorText; 

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _handleEmailPasswordLogin() async {
    final enteredEmail = _emailController.text.trim();
    final enteredPassword = _passwordController.text.trim();

    setState(() {
      _emailErrorText = null;
      _passwordErrorText = null;
    });

    if (enteredEmail.isEmpty) {
      _emailErrorText = 'El correo electrónico no puede estar vacío.';
    }
    if (enteredPassword.isEmpty) {
      _passwordErrorText = 'La contraseña no puede estar vacía.';
    }
    if (_emailErrorText != null || _passwordErrorText != null) {
      setState(() {});
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: enteredEmail,
        password: enteredPassword,
      );

      if (!mounted) return;
      // La referencia a la clase del proveedor ha sido cambiada a 'ParkingProvider'
      final provider = Provider.of<ParkingProvider>(context, listen: false);
      provider.login(_auth.currentUser?.displayName ?? 'Usuario', enteredEmail);

      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/parking'); // Redirige a la pantalla principal del mapa
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      
      setState(() {
        if (e.code == 'user-not-found' || e.code == 'invalid-email') {
          _emailErrorText = 'Usuario no encontrado o correo inválido.';
          _passwordErrorText = null; // Limpiar el error de contraseña si el correo es el problema
        } else if (e.code == 'wrong-password') {
          _passwordErrorText = 'Contraseña incorrecta.';
          _emailErrorText = null; // Limpiar el error de correo si la contraseña es el problema
        } else {
          _emailErrorText = 'Ocurrió un error. Intenta de nuevo.';
          _passwordErrorText = null;
        }
      });
    }
  }

  Future<void> _signInWithGoogle() async { /* ... */ }
  Future<void> _signInWithMicrosoft() async { /* ... */ }
  Future<void> _signInWithApple() async { /* ... */ }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Bienvenido a Smart Parking', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Inicia sesión para continuar', style: TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 30),
                _buildTextField(controller: _emailController, hintText: 'Usuario o Correo electrónico', keyboardType: TextInputType.emailAddress, errorText: _emailErrorText),
                const SizedBox(height: 12),
                _buildTextField(controller: _passwordController, hintText: 'Contraseña', obscureText: true, errorText: _passwordErrorText),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _handleEmailPasswordLogin,
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007AFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    child: const Text('Iniciar Sesión', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 25),
                Row(children: const [Expanded(child: Divider(color: Colors.grey)), Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text('o', style: TextStyle(color: Colors.grey))), Expanded(child: Divider(color: Colors.grey))]),
                const SizedBox(height: 25),
                SocialButton(label: 'Continuar con Google', icon: FontAwesomeIcons.google, onPressed: _signInWithGoogle),
                const SizedBox(height: 12),
                SocialButton(label: 'Continuar con Microsoft', icon: FontAwesomeIcons.microsoft, onPressed: _signInWithMicrosoft),
                const SizedBox(height: 12),
                SocialButton(label: 'Continuar con Apple', icon: FontAwesomeIcons.apple, onPressed: _signInWithApple),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿No tienes cuenta?'),
                    TextButton(onPressed: () {Navigator.pushNamed(context, '/register');}, child: const Text('Regístrate manual', style: TextStyle(color: Color(0xFF007AFF)))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget auxiliar para los campos de texto
Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? errorText
}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
        filled: true,
        fillColor: Colors.white,
        errorText: errorText,
      ),
    );
}

class SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const SocialButton({super.key, required this.label, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          side: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        icon: FaIcon(icon, color: Colors.black, size: 18),
        label: Text(label, style: const TextStyle(color: Colors.black, fontSize: 15)),
      ),
    );
  }
}
