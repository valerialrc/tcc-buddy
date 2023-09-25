import 'package:buddy/models/animal.dart';
import 'package:buddy/models/animals_manager.dart';
import 'package:buddy/models/user_app.dart';
import 'package:buddy/models/user_manager.dart';
import 'package:buddy/screens/animal_profile.dart';
import 'package:buddy/screens/animal_register.dart';
import 'package:buddy/screens/login.dart';
import 'package:buddy/screens/menu.dart';
import 'package:buddy/screens/profile.dart';
import 'package:buddy/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => AnimalsManager(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Buddy',
        debugShowCheckedModeBanner: false,
        theme: tema.copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(255, 9, 199, 151),
          colorScheme: tema.colorScheme.copyWith(
            primary: const Color.fromARGB(255, 9, 199, 151),
            secondary: Colors.white,
          ),
          textTheme: tema.textTheme.copyWith(
            headline6: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            headline5: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            headline4: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 79, 103, 116),
            ),
            headline3: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            headline2: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.blueGrey,
            ),
            button: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        initialRoute: '/menu',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/menu':
              return MaterialPageRoute(builder: (_) => Menu());
            case '/register':
              return MaterialPageRoute(builder: (_) => const Register());
            case '/registerAnimal':
              return MaterialPageRoute(
                  builder: (_) => RegisterAnimal(settings.arguments as Animal));
            case '/login':
              return MaterialPageRoute(builder: (_) => const Login());
            case '/animal':
              return MaterialPageRoute(
                  builder: (_) => AnimalProfile(settings.arguments as Animal));
            case '/profile':
              return MaterialPageRoute(
                  builder: (_) => Profile(settings.arguments as UserApp));
            default:
              return MaterialPageRoute(builder: (_) => Menu());
          }
        },
      ),
    );
  }
}
