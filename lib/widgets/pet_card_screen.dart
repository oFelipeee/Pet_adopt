import 'package:flutter/material.dart';
import 'package:pet_adopt/model/pet_model.dart';
import 'package:pet_adopt/view/pet_desc_screen.dart';

class PetCardScreen extends StatelessWidget {
  const PetCardScreen({
    super.key,
    required this.dog, // Passando o pet corretamente
  });

  final PetModel dog; // Usando PetModel

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navegação ao clicar no card
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PetDescScreen(dog: dog),
          ),
        );
      },
      borderRadius: BorderRadius.circular(10), // Efeito visual ao clicar
      child: Container(
        width: 150,
        height: 300,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color.fromARGB(94, 255, 0, 0),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: Image.network(
                dog.images.isNotEmpty
                    ? dog.images[0]
                    : "assets/images/default.png", // Exibe a primeira imagem
                fit: BoxFit.cover,
                width: double.infinity,
                height: 130,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${dog.name}, ${dog.age} anos", // Exibindo nome e idade
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
