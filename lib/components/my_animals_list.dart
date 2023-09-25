import 'package:buddy/models/animals_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/animal.dart';

class MyAnimalsList extends StatelessWidget {
  final AnimalsManager animals;

  const MyAnimalsList(this.animals, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Animal> myAnimals = animals.myAnimals;

    if (myAnimals.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 5),
        itemCount: myAnimals.length,
        itemBuilder: (context, index) {
          final animal = myAnimals[index];

          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/animal', arguments: animal);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 15,
                    left: 15,
                    bottom: 15,
                  ),
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.9),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(animal.images!.first),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  animal.name.toString(),
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text((animal.age.toString()),
                                    style:
                                        Theme.of(context).textTheme.headline3),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  FontAwesomeIcons.locationDot,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 16,
                                ),
                                const SizedBox(width: 5),
                                Text('Viçosa, MG',
                                    style:
                                        Theme.of(context).textTheme.headline2),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                padding: const EdgeInsets.only(left: 16),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/registerAnimal', arguments: animal);
                },
                icon: Icon(
                  FontAwesomeIcons.penToSquare,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          );
        },
      );
    } else {
      return Text(
        'Não há resultado para a busca.',
        style: Theme.of(context).textTheme.headline2,
      );
    }
  }
}
