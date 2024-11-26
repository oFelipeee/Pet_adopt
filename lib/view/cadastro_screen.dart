import 'package:flutter/material.dart';
import 'package:pet_adopt/view/login_screen.dart';
import '../controller/user_controller.dart';
import '../model/user_model.dart';
import 'home_screen.dart'; // Importa a HomeScreen

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _userController = UserController();
  final _formKey = GlobalKey<FormState>();
  final _user = UserModel();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_passwordController.text.trim() !=
          _confirmpasswordController.text.trim()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("As senhas não coincidem!")),
        );
        return;
      }

      _user.password = _passwordController.text;
      _user.confirmpassword = _confirmpasswordController.text;

      final message = await _userController.registerUser(_user);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

      if (message == 'Usuário cadastrado com sucesso!') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cadastro"),
          backgroundColor: Colors.red,
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
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
                    "Crie sua conta no PetAdopt!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const Text(
                    "Preencha os dados abaixo para começar 🐾",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(flex: 2),

              // Formulário de Cadastro
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person,
                            color: Color.fromARGB(255, 0, 0, 0)),
                        hintText: "Digite seu nome",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSaved: (value) => _user.name = value!,
                      validator: (value) =>
                          value!.isEmpty ? "Nome é obrigatório" : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
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
                      onSaved: (value) => _user.email = value!,
                      validator: (value) =>
                          value!.isEmpty ? "Email é obrigatório" : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone,
                            color: Color.fromARGB(255, 0, 0, 0)),
                        hintText: "Digite seu telefone",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSaved: (value) => _user.phone = value!,
                      validator: (value) =>
                          value!.isEmpty ? "Telefone é obrigatório" : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
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
                      validator: (value) =>
                          value!.isEmpty ? "Senha é obrigatória" : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmpasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock,
                            color: Color.fromARGB(255, 0, 0, 0)),
                        hintText: "Confirme sua senha",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Confirmação de senha é obrigatória";
                        }
                        if (value.trim() != _passwordController.text.trim()) {
                          return "As senhas não coincidem";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Botão de Cadastro
              ElevatedButton(
                onPressed: _registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Cadastrar",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
