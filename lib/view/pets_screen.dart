import 'package:flutter/material.dart';
import 'package:pet_adopt/controller/pet_controller.dart';
import 'package:pet_adopt/view/add_pet_screen.dart';
import 'package:pet_adopt/view/profile_screen.dart';
import 'package:pet_adopt/widgets/pet_card_screen.dart';
import 'package:pet_adopt/model/pet_model.dart';

class PetsScreen extends StatefulWidget {
  const PetsScreen({super.key});

  @override
  _PetsScreenState createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  late Future<List<PetModel>> pets;

  @override
  void initState() {
    super.initState();
    pets = PetController().fetchPets();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200], // Cor de fundo cinza claro
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Título com slogan e ícone
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.pets,
                    size: 30,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Encontre seu novo amigo",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Botões de Ação
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddPetScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Adicionar Pet",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          "Perfil",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.person,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Campo de Pesquisa
              TextField(
                decoration: InputDecoration(
                  hintText: "Pesquisar Pet",
                  filled: true,
                  fillColor: Colors.white, // Fundo branco no campo de texto
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),

              // Lista de Pets
              Expanded(
                child: FutureBuilder<List<PetModel>>(
                  future: pets,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erro: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      List<PetModel> petList = snapshot.data!;
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: petList.length,
                        itemBuilder: (context, index) {
                          return PetCardScreen(dog: petList[index]);
                        },
                      );
                    } else {
                      return const Center(
                          child: Text(
                        'Nenhum pet encontrado.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
