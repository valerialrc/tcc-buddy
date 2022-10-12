import 'package:buddy/models/user.dart';

class Animal {
  final int id;
  final String name;
  final String image;
  final String description;
  final String species;
  final String breed;
  final int age;
  final String sex;
  final double weight;
  final String color;
  final String regDate;
  final User owner;

  Animal({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.species,
    required this.breed,
    required this.age,
    required this.sex,
    required this.weight,
    required this.color,
    required this.regDate,
    required this.owner,
  });
}

var owner = User(
    name: 'Valéria Carneiro',
    image: 'assets/images/perfil.jfif',
    description:
        'Sou simpatizante da causa animal e dou lar temporário para alguns bichinhos.');
var animals = [
  Animal(
    id: 00001,
    name: 'Lola',
    image: 'assets/images/lola.jpg',
    description: 'Cachorrinha caramelo muito carinhosa!',
    species: 'Cachorro',
    breed: 'Sem Raça Definida',
    age: 3,
    sex: 'Fêmea',
    weight: 9.5,
    color: 'Caramelo',
    regDate: '02/10/2022',
    owner: owner,
  ),
  Animal(
    id: 00002,
    name: 'Chico',
    image: 'assets/images/chico.jpg',
    description: 'Gatinho branco',
    species: 'Gato',
    breed: 'Sem Raça Definida',
    age: 1,
    sex: 'Macho',
    weight: 8,
    color: 'White',
    regDate: '02/10/2022',
    owner: owner,
  ),
];
