import 'dart:io';

import 'package:buddy/models/user_app.dart';
import 'package:buddy/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../helpers/validators.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController passController = TextEditingController();

  final TextEditingController confirmPassController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  UserApp userApp = UserApp(email: '', password: '', name: '', id: '');

  XFile? image;

  @override
  Widget build(BuildContext context) {
    selectImage() async {
      final ImagePicker picker = ImagePicker();

      try {
        XFile? file = await picker.pickImage(source: ImageSource.gallery);
        if (file != null) setState(() => image = file);
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(),
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
                      Container(
                        padding: const EdgeInsets.only(bottom: 16),
                        alignment: Alignment.center,
                        child: Text(
                          'Crie sua Conta',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),

                      Container(
                        color: Theme.of(context).colorScheme.secondary,
                        child: TextFormField(
                          enabled: !userManager.loading,
                          keyboardType: TextInputType.text,
                          cursorColor: Theme.of(context).colorScheme.primary,
                          validator: (name) {
                            if (name!.isEmpty) {
                              return 'Campo obrigatório';
                            } else if (name.trim().split(' ').length <= 1) {
                              return 'Preencha seu nome completo';
                            }
                            return null;
                          },
                          onSaved: (name) => userApp.name = name!,
                          decoration: const InputDecoration(
                            labelText: 'Nome Completo',
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
                          enabled: !userManager.loading,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Theme.of(context).colorScheme.primary,
                          autocorrect: false,
                          validator: (email) {
                            if (email!.isEmpty) {
                              return 'Campo obrigatório';
                            } else if (!emailValid(email)) {
                              return 'E-mail inválido';
                            }
                            return null;
                          },
                          onSaved: (email) => userApp.email = email!,
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
                          enabled: !userManager.loading,
                          obscureText: true,
                          cursorColor: Theme.of(context).colorScheme.primary,
                          autocorrect: false,
                          controller: passController,
                          validator: (pass) {
                            if (pass!.isEmpty) {
                              return 'Campo obrigatório';
                            } else if (pass.length < 6) {
                              return 'Sua senha deve ter mais de 6 dígitos';
                            }
                            return null;
                          },
                          onSaved: (pass) => userApp.password = pass!,
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
                      const SizedBox(height: 10),
                      Container(
                        color: Theme.of(context).colorScheme.secondary,
                        child: TextFormField(
                          enabled: !userManager.loading,
                          obscureText: true,
                          cursorColor: Theme.of(context).colorScheme.primary,
                          autocorrect: false,
                          controller: confirmPassController,
                          validator: (pass) {
                            if (pass!.isEmpty) {
                              return 'Campo obrigatório';
                            } else if (pass.length < 6) {
                              return 'Sua senha deve ter mais de 6 dígitos';
                            } else if (pass != passController.text) {
                              return 'As senhas são diferentes';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Confirme a Senha',
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
                      FormField(
                        validator: (image) =>
                            image == null ? 'Campo obrigatório' : null,
                        onSaved: (image) => userApp.image = image as String?,
                        builder: (_) => ListTile(
                          leading: Icon(FontAwesomeIcons.camera),
                          title: Text(
                            'Adicionar foto',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          onTap: selectImage,
                          trailing: image != null
                              ? AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.file(
                                    File(image!.path),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      // const SizedBox(height: 10),
                      // Row(children: [
                      //   Checkbox(
                      //     activeColor: Theme.of(context).colorScheme.primary,
                      //     value: false,
                      //     onChanged: ((value) => true),
                      //   ),
                      //   Expanded(
                      //     child: RichText(
                      //       text: TextSpan(
                      //         text: 'Estou de acordo com os ',
                      //         style: Theme.of(context).textTheme.headline4,
                      //         children: [
                      //           TextSpan(
                      //             text: 'Termos de Uso do Buddy!',
                      //             style: TextStyle(
                      //                 fontFamily: 'OpenSans',
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.w400,
                      //                 color: Theme.of(context)
                      //                     .colorScheme
                      //                     .primary),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ]),
                      const SizedBox(height: 20),
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
                                          formKey.currentState?.save();
                                          userManager.signUp(
                                              userApp: userApp,
                                              onFail: (e) {
                                                (ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'Falha ao cadastrar: $e'),
                                                        backgroundColor:
                                                            Colors.red)));
                                              },
                                              onSuccess: () {
                                                Navigator.of(context).pop();
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
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                      )
                                    : Text(
                                        'Cadastrar',
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: const Divider(
                      //         height: 20,
                      //         thickness: 2,
                      //         color: Colors.grey,
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.all(10),
                      //       child: Text(
                      //         'Ou',
                      //         style: TextStyle(
                      //           fontFamily: 'OpenSans',
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.w500,
                      //           color: Colors.blueGrey,
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: const Divider(
                      //         height: 20,
                      //         thickness: 2,
                      //         color: Colors.grey,
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
                      //             primary: Color(0xff3b5998),
                      //             //shadowColor: Color(0xff3b5998),
                      //             elevation: 10,
                      //           ),
                      //           child: FittedBox(
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Icon(FontAwesomeIcons.facebook),
                      //                 SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 Text(
                      //                   'Cadastrar com o Facebook',
                      //                   style: Theme.of(context).textTheme.button,
                      //                 ),
                      //               ],
                      //             ),
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
                      //                 'Cadastrar com o Google',
                      //                 style: Theme.of(context).textTheme.button,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
