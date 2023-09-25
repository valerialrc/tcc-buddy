import 'package:buddy/models/user_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'animal.dart';

class AnimalsManager extends ChangeNotifier {
  UserManager? owner;

  AnimalsManager() {
    owner = UserManager();
    _loadAllAnimals();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Animal> _allAnimals = [];

  String _search = '';

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Animal> get filteredAnimals {
    final List<Animal> filteredAnimals = [];

    if (search.isEmpty) {
      filteredAnimals.addAll(_allAnimals);
    } else {
      filteredAnimals.addAll(_allAnimals.where(
          (p) => p.description!.toLowerCase().contains(search.toLowerCase())));
      filteredAnimals.addAll(_allAnimals.where(
          (p) => p.ownerId!.toLowerCase().contains(search.toLowerCase())));
    }

    return filteredAnimals;
  }

  List<Animal> get myAnimals {
    final List<Animal> myAnimals = [];

    myAnimals.addAll(_allAnimals.where((p) =>
        p.ownerId!.toLowerCase().contains(owner!.appUser!.id!.toLowerCase())));

    return myAnimals;
  }

  Future<void> _loadAllAnimals() async {
    final QuerySnapshot snapAnimals =
        await firestore.collection('animals').get();

    _allAnimals = snapAnimals.docs.map((d) => Animal.fromDocument(d)).toList();

    notifyListeners();
  }
}
