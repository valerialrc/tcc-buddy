import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/animal.dart';
import '../screens/animal_profile.dart';

class AnimalsList extends StatelessWidget {
  final List<Animal> animals;

  AnimalsList(this.animals);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 5),
      itemCount: animals.length,
      itemBuilder: (context, index) {
        final animal = animals[index];

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AnimalProfile(animal),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(
              right: 15,
              left: 15,
              bottom: 15,
            ),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          image: AssetImage(animal.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          animal.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                            (animal.age > 1)
                                ? '${animal.sex}, ${animal.age} anos'
                                : '${animal.sex}, ${animal.age} ano',
                            style: Theme.of(context).textTheme.headline5),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.mapMarkerAlt,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Text('Localização: Viçosa, MG',
                            style: Theme.of(context).textTheme.headline5),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
