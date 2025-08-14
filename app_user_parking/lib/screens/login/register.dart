import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _generalErrorText; 
  String? _passwordErrorText; 
  String? _emailErrorText; 

  Future<void> _handleRegister() async {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    setState(() {
      _generalErrorText = null;
      _passwordErrorText = null;
      _emailErrorText = null;
    });

    if (fullName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        setState(() {
            _generalErrorText = 'Por favor, llena todos los campos.';
        });
        return;
    }

    if (password != confirmPassword) {
      setState(() {
        _passwordErrorText = 'Las contraseñas no coinciden.';
      });
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(fullName);

      if (!mounted) return;
      
      Navigator.pushReplacementNamed(context, '/parking');
      
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      
      setState(() {
        if (e.code == 'weak-password') {
          _passwordErrorText = 'La contraseña es muy débil.';
        } else if (e.code == 'email-already-in-use') {
          _emailErrorText = 'La cuenta ya existe para ese correo electrónico.';
        } else {
          _generalErrorText = 'Ocurrió un error. Intenta de nuevo.';
        }
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCFCFC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(), 
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Crear Cuenta', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Regístrate para empezar a usar Smart Parking', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.grey)),
                if (_generalErrorText != null)
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(_generalErrorText!, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
                    ),
                const SizedBox(height: 30),
                _buildTextField(controller: _fullNameController, hintText: 'Nombre Completo'),
                const SizedBox(height: 12),
                _buildTextField(controller: _emailController, hintText: 'Correo electrónico', keyboardType: TextInputType.emailAddress, errorText: _emailErrorText),
                const SizedBox(height: 12),
                _buildTextField(controller: _passwordController, hintText: 'Contraseña', obscureText: true, errorText: _passwordErrorText),
                const SizedBox(height: 12),
                _buildTextField(controller: _confirmPasswordController, hintText: 'Confirmar Contraseña', obscureText: true),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _handleRegister,
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007AFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    child: const Text('Registrarse', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿Ya tienes cuenta?'),
                    TextButton(onPressed: () {Navigator.pop(context);}, child: const Text('Inicia sesión', style: TextStyle(color: Color(0xFF007AFF), fontWeight: FontWeight.bold))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String hintText,
      bool obscureText = false,
      TextInputType keyboardType = TextInputType.text,
      String? errorText}) {
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
}