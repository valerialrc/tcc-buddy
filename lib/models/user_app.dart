import 'package:cloud_firestore/cloud_firestore.dart';

class UserApp {
  String? id;
  String email;
  String? password;
  String name;
  String? image;
  // final String description;

  UserApp({
    this.id,
    required this.email,
    this.password,
    required this.name,
    this.image,
    // required this.description,
  });

  UserApp.fromDocument(DocumentSnapshot<Map<String, dynamic>> document)
      : name = document['name'] as String,
        email = document['email'] as String,
        image = document['image'] as String {
    id = document.id;
  }

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
