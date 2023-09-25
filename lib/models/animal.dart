import 'package:buddy/models/user_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Animal {
  Animal.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    images = List<String>.from(document['images'] as List<dynamic>);
    description = document['description'] as String;
    species = document['species'] as String;
    breed = document['breed'] as String;
    age = document['age'] as String;
    sex = document['sex'] as String;
    weight = document['weight'] as String;
    regDate = document['regDate'] as String;
    ownerId = document['owner'] as String;
    firestore
        .doc('users/$ownerId')
        .get()
        .then((doc) => owner = UserApp.fromDocument(doc));
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? id;
  String? name;
  List<String>? images;
  String? description;
  String? species;
  String? breed;
  String? age;
  String? sex;
  String? weight;
  String? regDate;
  String? ownerId;
  UserApp? owner;

  Animal(
      {this.id,
      this.name,
      this.images,
      this.description,
      this.species,
      this.breed,
      this.age,
      this.sex,
      this.weight,
      this.regDate,
      this.ownerId,
      this.owner});
}
