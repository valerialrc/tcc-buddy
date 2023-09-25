import 'package:buddy/components/custom_drawer_header.dart';
import 'package:buddy/components/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.primary.withOpacity(0.9),
                ],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ListView(
            children: const [
              CustomDrawerHeader(),
              Divider(),
              DrawerTile(
                iconData: FontAwesomeIcons.house,
                title: 'Início',
                page: 0,
              ),
              DrawerTile(
                iconData: FontAwesomeIcons.person,
                title: 'Meu Perfil',
                page: 1,
              ),
              DrawerTile(
                iconData: FontAwesomeIcons.paw,
                title: 'Meus bichinhos',
                page: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
