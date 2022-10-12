import 'package:buddy/components/animals_list.dart';
import 'package:buddy/screens/animal_profile.dart';
import 'package:buddy/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:buddy/models/animal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'filter_modal.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  _openFilterModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return FilterModal();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Padding(
        padding: const EdgeInsets.only(top: 55),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(FontAwesomeIcons.bars),
                  Column(
                    children: [
                      Text(
                        'Localização',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Text(
                            ' Viçosa, MG',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => Profile(owner),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      child: ClipOval(
                        child: Image(
                          height: 40,
                          width: 40,
                          image: AssetImage(owner.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.search),
                            Expanded(
                              child: TextField(
                                style: Theme.of(context).textTheme.headline6,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText: 'Pesquisar',
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => _openFilterModal(context),
                              icon: Icon(FontAwesomeIcons.filter),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: AnimalsList(animals)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
