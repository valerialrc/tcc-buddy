import 'package:buddy/models/animal.dart';
import 'package:buddy/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/images_form.dart';

class RegisterAnimal extends StatelessWidget {
  Animal animal;

  RegisterAnimal(this.animal, {super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastrar Animal',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
        child: Form(
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
                      TextFormField(
                        keyboardType: TextInputType.text,
                        cursorColor: Theme.of(context).colorScheme.primary,
                        validator: (name) {
                          if (name!.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Nome do animal',
                          labelStyle: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        cursorColor: Theme.of(context).colorScheme.primary,
                        validator: (age) {
                          if (age!.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Idade',
                          labelStyle: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        cursorColor: Theme.of(context).colorScheme.primary,
                        validator: (sex) {
                          if (sex!.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Sexo',
                          labelStyle: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        cursorColor: Theme.of(context).colorScheme.primary,
                        validator: (species) {
                          if (species!.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Espécie',
                          labelStyle: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        cursorColor: Theme.of(context).colorScheme.primary,
                        validator: (breed) {
                          if (breed!.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Raça',
                          labelStyle: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(),
                        cursorColor: Theme.of(context).colorScheme.primary,
                        validator: (weight) {
                          if (weight!.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Peso em kg',
                          labelStyle: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        cursorColor: Theme.of(context).colorScheme.primary,
                        validator: (description) {
                          if (description!.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Descrição',
                          labelStyle: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ImagesForm(animal),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 55,
                              child: ElevatedButton(
                                onPressed: (() => {}),
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
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
