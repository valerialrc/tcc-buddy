import 'package:buddy/screens/edit_animals.dart';
import 'package:buddy/screens/login.dart';
import 'package:buddy/screens/main_screen.dart';
import 'package:buddy/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/custom_drawer.dart';
import '../models/page_manager.dart';
import '../models/user_manager.dart';

class Menu extends StatelessWidget {
  Menu({super.key});

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManager>(
      builder: (_, userManager, __) {
        return userManager.isLoggedIn
            ? Provider(
                create: (_) => PageManager(pageController),
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const MainScreen(),
                    Consumer<UserManager>(
                      builder: (_, userManager, __) {
                        return Profile(userManager.appUser!);
                      },
                    ),
                    const EditAnimals(),
                    Scaffold(
                      drawer: const CustomDrawer(),
                      appBar: AppBar(
                        title: const Text('Home4'),
                      ),
                    ),
                  ],
                ),
              )
            : const Login();
      },
    );
  }
}
