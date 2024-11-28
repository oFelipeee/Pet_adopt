class PetModel {
  final String name;
  final int age;
  final double weight;
  final String color;
  final List<String> images;

  // Construtor para inicializar o modelo Pet
  PetModel({
    required this.name,
    required this.age,
    required this.weight,
    required this.color,
    required this.images,
  });

  // Método para converter o JSON da resposta da API para o modelo Pet
  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      name: json['name'],
      age: json['age'],
      weight: json['weight'].toDouble(),
      color: json['color'],
      images: List<String>.from(
          json['images'] ?? []), // Garantir que seja uma lista de strings
    );
  }

  // Método para retornar a URL da imagem principal (primeira imagem na lista)
  String get imageUrl {
    return images.isNotEmpty
        ? images[0]
        : ''; // Se houver imagens, usa a primeira
  }

  // A descrição do animal pode ser uma string fixa ou nula, dependendo do seu caso
  String get description {
    // Suponha que a descrição seja uma string fixa ou obtenha de algum lugar
    return "Este é um pet adorável que está à espera de um lar.";
  }

  // Se o gênero for necessário, você pode adicionar conforme a lógica da sua aplicação
  String get gender {
    // Adicione a lógica aqui para determinar o sexo ou obtenha de algum campo da API
    return "Masculino"; // Exemplo fixo
  }

  get location => null;
}
