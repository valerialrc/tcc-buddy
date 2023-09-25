import 'package:buddy/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/validators.dart';
import '../models/user_app.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Entrar',
      //     style: Theme.of(context).textTheme.headline5,
      //   ),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      // ),
      key: scaffoldMessengerKey,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Form(
        key: formKey,
        child: Consumer<UserManager>(
          builder: (_, userManager, __) {
            return Center(
              child: Card(
                margin: const EdgeInsets.all(16),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 300,
                      width: 200,
                      child: Image(
                        image: const AssetImage(
                            'assets/images/app/logo_completa.png'),
                        fit: BoxFit.cover,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Container(
                      color: Theme.of(context).colorScheme.secondary,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        enabled: !userManager.loading,
                        cursorColor: Theme.of(context).colorScheme.primary,
                        controller: emailController,
                        validator: (email) {
                          if (!emailValid(email!)) return 'E-mail inválido';
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      color: Theme.of(context).colorScheme.secondary,
                      child: TextFormField(
                        obscureText: true,
                        cursorColor: Theme.of(context).colorScheme.primary,
                        autocorrect: false,
                        enabled: !userManager.loading,
                        controller: passController,
                        validator: (pass) {
                          if (pass!.isEmpty || pass.length < 6) {
                            return 'Senha Inválida';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Recuperar Senha',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 55,
                            child: ElevatedButton(
                              onPressed: userManager.loading
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        userManager.signIn(
                                            userApp: UserApp(
                                                email: emailController.text,
                                                password: passController.text,
                                                name: '',
                                                id: ''),
                                            onFail: (e) {
                                              (ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Falha ao entrar: $e'),
                                                      backgroundColor:
                                                          Colors.red)));
                                            },
                                            onSuccess: () {
                                              //Navigator.of(context).pop();
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      '/menu');
                                            });
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                elevation: 10,
                                disabledBackgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withAlpha(100),
                              ),
                              child: userManager.loading
                                  ? const CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    )
                                  : Text(
                                      'Entrar',
                                      style: Theme.of(context).textTheme.button,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Container(
                    //         height: 55,
                    //         child: ElevatedButton(
                    //           onPressed: () {},
                    //           style: ElevatedButton.styleFrom(
                    //             primary: Color(0xff3b5998),
                    //             //shadowColor: Color(0xff3b5998),
                    //             elevation: 10,
                    //           ),
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Icon(FontAwesomeIcons.facebook),
                    //               SizedBox(
                    //                 width: 10,
                    //               ),
                    //               Text(
                    //                 'Entrar com o Facebook',
                    //                 style: Theme.of(context).textTheme.button,
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Container(
                    //         height: 55,
                    //         child: ElevatedButton(
                    //           onPressed: () {},
                    //           style: ElevatedButton.styleFrom(
                    //             primary: Color(0xffdb4a39),
                    //             //shadowColor: Theme.of(context).colorScheme.secondary,
                    //             elevation: 10,
                    //           ),
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Icon(FontAwesomeIcons.google),
                    //               SizedBox(
                    //                 width: 10,
                    //               ),
                    //               Text(
                    //                 'Entrar com o Google',
                    //                 style: Theme.of(context).textTheme.button,
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Row(
                      children: const [
                        Expanded(
                          child: Divider(
                            height: 20,
                            thickness: 2,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Ou',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            height: 20,
                            thickness: 2,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/register');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                //shadowColor: Theme.of(context).colorScheme.secondary,
                                elevation: 10,
                              ),
                              child: Text(
                                'Cadastrar',
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
