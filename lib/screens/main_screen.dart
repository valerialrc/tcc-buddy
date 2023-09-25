import 'package:buddy/components/animals_list.dart';
import 'package:buddy/components/custom_drawer.dart';
import 'package:buddy/components/location.dart';
import 'package:buddy/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:buddy/models/animals_manager.dart';

import '../models/page_manager.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late TextEditingController searchController = TextEditingController();

  // _openFilterModal(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (_) {
  //         return FilterModal();
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.locationDot,
                color: Theme.of(context).colorScheme.secondary,
                size: 20,
              ),
              const Location(),
              // Text(
              //   ' Viçosa, MG',
              //   style: Theme.of(context).textTheme.headline3,
              // ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          Consumer<UserManager>(
            builder: (_, userManager, __) {
              if (userManager.isLoggedIn) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () {
                      context.read<PageManager>().setPage(1);
                    },
                    child: CircleAvatar(
                      child: ClipOval(
                        child: Image(
                          height: 40,
                          width: 40,
                          image: NetworkImage(userManager.appUser!.image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.only(right: 16),
                );
              }
            },
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            textInputAction: TextInputAction.search,
                            style: Theme.of(context).textTheme.headline3,
                            controller: searchController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              contentPadding: const EdgeInsets.all(10),
                              hintText: 'Pesquisar',
                              prefixIcon: IconButton(
                                icon: const Icon(
                                    FontAwesomeIcons.magnifyingGlass),
                                color: Theme.of(context).colorScheme.primary,
                                onPressed: () {},
                              ),
                            ),
                            onFieldSubmitted: (text) async {
                              final search = text;
                              context.read<AnimalsManager>().search = search;
                            },
                          ),
                        ),
                        Consumer<AnimalsManager>(
                            builder: (_, animalManager, __) {
                          if (animalManager.search.isNotEmpty) {
                            return IconButton(
                              onPressed: () {
                                animalManager.search = '';
                                searchController.clear();
                              },
                              icon: const Icon(FontAwesomeIcons.xmark),
                            );
                          } else {
                            return Container();
                          }
                        }),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Consumer<AnimalsManager>(
                      builder: (_, animalsManager, __) {
                        return AnimalsList(animalsManager);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
