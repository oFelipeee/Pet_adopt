import 'package:flutter/material.dart';
import 'package:pet_adopt/controller/auth_controller.dart';
import 'package:pet_adopt/view/cadastro_screen.dart';
import 'package:pet_adopt/view/pets_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authController = AuthController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text;
      final password = _passwordController.text;

      final token = await _authController.loginUser(email, password);

      if (token != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login bem-sucedido!")),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const PetsScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Falha ao realizar login!")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          backgroundColor: Colors.red,
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // Header com ícone ou imagem
              Column(
                children: [
                  Icon(
                    Icons.pets,
                    size: 80,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Bem-vindo(a) ao PetAdopt!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const Text(
                    "Encontre o pet perfeito para adoção 🐶🐱",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(flex: 2),

              // Formulário de Login
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, insira um email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email,
                            color: Color.fromARGB(255, 0, 0, 0)),
                        hintText: "Digite seu email",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, insira sua senha";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock,
                            color: Color.fromARGB(255, 0, 0, 0)),
                        hintText: "Digite sua senha",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Botões de Login e Cadastro
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Entrar",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CadastroScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[100],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Registrar",
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 3),

            ],
          ),
        ),
      ),
    );
  }
}
