import 'package:flutter/material.dart';
import 'package:pet_adopt/controller/pet_controller.dart';

class AddPetScreen extends StatelessWidget {
  AddPetScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController storyController = TextEditingController();

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),

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
                const SizedBox(height: 20),

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
                  genderController,
                  "Gênero do Pet",
                  prefixIcon: Icons.transgender,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  categoryController,
                  "Categoria do Pet",
                  prefixIcon: Icons.category,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  breedController,
                  "Raça do Pet",
                  prefixIcon: Icons.pets,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  storyController,
                  "História do Pet",
                  prefixIcon: Icons.book,
                  maxLines: 3,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  imageController,
                  "URL da Imagem do Pet",
                  prefixIcon: Icons.link,
                ),
                const SizedBox(height: 20),

                // Botão de Adicionar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Validação dos campos
                      if (_validateFields(context)) {
                        try {
                          await petController.addPet(
                            name: nameController.text,
                            age: int.parse(ageController.text),
                            weight: double.parse(weightController.text),
                            color: colorController.text,
                            gender: genderController.text,
                            category: categoryController.text,
                            breed: breedController.text,
                            story: storyController.text,
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
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Função para validar os campos
  bool _validateFields(BuildContext context) {
    if (nameController.text.isEmpty ||
        ageController.text.isEmpty ||
        weightController.text.isEmpty ||
        colorController.text.isEmpty ||
        genderController.text.isEmpty ||
        categoryController.text.isEmpty ||
        breedController.text.isEmpty ||
        storyController.text.isEmpty ||
        imageController.text.isEmpty) {
      _showAlert(context, "Por favor, preencha todos os campos.");
      return false;
    }

    if (int.tryParse(ageController.text) == null || int.parse(ageController.text) <= 0) {
      _showAlert(context, "Idade inválida. Por favor, insira um número positivo.");
      return false;
    }

    if (double.tryParse(weightController.text) == null || double.parse(weightController.text) <= 0) {
      _showAlert(context, "Peso inválido. Por favor, insira um número positivo.");
      return false;
    }

    return true;
  }

  // Função para exibir o alerta
  void _showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Erro"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    TextInputType? keyboardType,
    IconData? prefixIcon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
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
