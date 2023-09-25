import 'package:buddy/components/animals_list.dart';
import 'package:buddy/components/custom_drawer.dart';
import 'package:buddy/models/animals_manager.dart';
import 'package:buddy/models/user_app.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/user_manager.dart';

class Profile extends StatefulWidget {
  final UserApp user;

  const Profile(this.user, {super.key});

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
      backgroundColor: Theme.of(context).colorScheme.primary,
      drawer: const CustomDrawer(),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.7)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  right: width * 0.05, left: width * 0.05, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<UserManager>(builder: (_, userManager, __) {
                    return SizedBox(
                      height: width * 0.4,
                      width: width * 0.4,
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image(
                            height: width * 0.4,
                            width: width * 0.4,
                            image: NetworkImage(userManager.appUser!.image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          widget.user.name,
                          style: const TextStyle(
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
                              FontAwesomeIcons.locationDot,
                              color: Theme.of(context).colorScheme.primary,
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
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        state = 1;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shadowColor: Theme.of(context).colorScheme.primary,
                      elevation: 10,
                    ),
                    child: Text(
                      'Disponíveis',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 22 * mediaQuery.textScaleFactor,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      state = 2;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shadowColor: Theme.of(context).colorScheme.primary,
                      elevation: 10,
                    ),
                    child: Text(
                      'Eu adotei',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 22 * mediaQuery.textScaleFactor,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      state = 3;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shadowColor: Theme.of(context).colorScheme.primary,
                      elevation: 10,
                    ),
                    child: Text(
                      'Eu doei',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 22 * mediaQuery.textScaleFactor,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<AnimalsManager>(
                builder: (_, animalsManager, __) {
                  if (state == 0) {
                    return AnimalsList(animalsManager);
                  } else {
                    return AnimalsList(animalsManager);
                  }

                  //else if(state == 2)

                  // else if(state == 3)
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
