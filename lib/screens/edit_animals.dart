import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../components/custom_drawer.dart';
import '../components/my_animals_list.dart';
import '../models/animal.dart';
import '../models/animals_manager.dart';
import '../models/user_manager.dart';

class EditAnimals extends StatelessWidget {
  const EditAnimals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Animais',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Consumer<UserManager>(builder: (_, userManager, __) {
              return IconButton(
                onPressed: () {
                  Animal animal = Animal();
                  Navigator.of(context)
                      .pushNamed('/registerAnimal', arguments: animal);
                },
                icon: const Icon(FontAwesomeIcons.plus),
              );
            }),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Container(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight,
              child: Column(
                children: [
                  Expanded(
                    child: Consumer<AnimalsManager>(
                      builder: (_, animalManager, __) {
                        return MyAnimalsList(animalManager);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
