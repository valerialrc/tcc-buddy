import 'dart:io';

import 'package:buddy/models/animal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm(this.animal, {super.key});

  final Animal animal;

  @override
  Widget build(BuildContext context) {
    var im;
    return FormField<List<dynamic>>(
      initialValue: List.from(
          animal.images != null ? animal.images as List<dynamic> : []),
      builder: (state) {
        void onImageSelected(File file) {
          state.value!.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return Row(
          children: [
            Text(
              'Imagens:',
              style: Theme.of(context).textTheme.headline4,
            ),
            if (animal.images != null)
              SizedBox(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: animal.images != null ? animal.images!.length : 0,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image(
                              height: 30,
                              fit: BoxFit.cover,
                              image: state.value!.map((image) {
                                im = image;
                                if (image is String) {
                                  return NetworkImage(image);
                                } else {
                                  return FileImage(image) as ImageProvider;
                                }
                              }).toList()[index],
                            ),
                            IconButton(
                              onPressed: () {
                                state.value?.remove(im);
                                state.didChange(state.value);
                              },
                              icon: const Icon(
                                FontAwesomeIcons.xmark,
                                size: 15,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              Container(),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => ImageSourceSheet(
                    onImageSelected: onImageSelected,
                  ),
                );
              },
              icon: Icon(
                FontAwesomeIcons.plus,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        );
      },
    );
  }
}
