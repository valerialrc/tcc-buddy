import 'package:buddy/components/animals_list.dart';
import 'package:buddy/models/user.dart';
import 'package:buddy/models/animal.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  final User user;

  Profile(this.user);

  @override
  State<Profile> createState() => _ProfileState();
}

var state = 0;

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Container(
        padding: const EdgeInsets.only(top: 65),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.7)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  right: width * 0.05, left: width * 0.05, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: width * 0.4,
                    width: width * 0.4,
                    child: CircleAvatar(
                      child: ClipOval(
                        child: Image(
                          height: width * 0.4,
                          width: width * 0.4,
                          image: AssetImage(widget.user.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          widget.user.name,
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            Text(
                              ' Viçosa, MG',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        state = 1;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      shadowColor: Theme.of(context).colorScheme.secondary,
                      elevation: 10,
                    ),
                    child: Text(
                      'Disponíveis',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      state = 2;
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      shadowColor: Theme.of(context).colorScheme.secondary,
                      elevation: 10,
                    ),
                    child: Text(
                      'Eu adotei',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 22 * mediaQuery.textScaleFactor,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      state = 3;
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      shadowColor: Theme.of(context).colorScheme.secondary,
                      elevation: 10,
                    ),
                    child: Text(
                      'Eu doei',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (state == 0)
              Expanded(
                child: AnimalsList(animals),
              )
            // else if(state == 1)

            // else if(state == 2)

            // else if(state == 3)
          ],
        ),
      ),
    );
  }
}
