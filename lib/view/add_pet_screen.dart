import 'package:flutter/material.dart';
import 'package:pet_adopt/controller/pet_controller.dart';

class AddPetScreen extends StatelessWidget {
  AddPetScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PetController petController = PetController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Adicionar Pet para Adoção"),
          backgroundColor: Colors.red,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Ícone e Header
              Column(
                children: [
                  Icon(
                    Icons.pets,
                    size: 80,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Adicione um novo amigo!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    "Preencha as informações abaixo.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(flex: 2),

              // Campos de entrada
              _buildTextField(
                nameController,
                "Nome do Pet",
                prefixIcon: Icons.edit,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                ageController,
                "Idade do Pet",
                keyboardType: TextInputType.number,
                prefixIcon: Icons.cake,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                weightController,
                "Peso do Pet (kg)",
                keyboardType: TextInputType.number,
                prefixIcon: Icons.line_weight,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                colorController,
                "Cor do Pet",
                prefixIcon: Icons.color_lens,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                imageController,
                "URL da Imagem do Pet",
                prefixIcon: Icons.link,
              ),
              const Spacer(),

              // Botão de Adicionar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await petController.addPet(
                        name: nameController.text,
                        age: int.parse(ageController.text),
                        weight: double.parse(weightController.text),
                        color: colorController.text,
                        images: [imageController.text],
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Pet cadastrado com sucesso!')),
                      );
                      Navigator.of(context).pop();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erro: $e')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Adicionar Pet",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    TextInputType? keyboardType,
    IconData? prefixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: Colors.red),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
