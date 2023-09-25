import 'package:buddy/models/animal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';

class AnimalProfile extends StatelessWidget {
  final Animal animal;

  const AnimalProfile(this.animal, {super.key});

  Widget _card(String title, String value, BuildContext context) {
    return FittedBox(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 120,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'buddy',
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 35,
              fontWeight: FontWeight.w500,
              fontFamily: 'LilitaOne'),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          child: Carousel(
            autoplayDuration: const Duration(seconds: 10),
            dotSize: 3,
            dotBgColor: Colors.transparent,
            dotColor: Theme.of(context).colorScheme.primary,
            images: animal.images?.map(
              (url) {
                return NetworkImage(url);
              },
            ).toList(),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        animal.name.toString(),
                        style: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            FontAwesomeIcons.locationDot,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Text(
                            //TODO
                            ' Viçosa, MG',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      _card('Idade', '${animal.age}', context),
                      const SizedBox(
                        width: 20,
                      ),
                      _card('Sexo', animal.sex.toString(), context),
                      const SizedBox(
                        width: 20,
                      ),
                      _card('Peso', animal.weight.toString(), context),
                      const SizedBox(
                        width: 20,
                      ),
                      _card('Raça', animal.breed.toString(), context),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  NetworkImage(animal.owner!.image.toString()),
                            ),
                            const SizedBox(width: 8),
                            FittedBox(
                              child: Text(animal.owner!.name,
                                  style: Theme.of(context).textTheme.headline6),
                            ),
                          ],
                        ),
                        Text(
                          animal.regDate.toString(),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      animal.description.toString(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.heart,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.comment,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(
                width: 170,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shadowColor: Theme.of(context).colorScheme.primary,
                    elevation: 20,
                  ),
                  child: Text(
                    'Adotar!',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
