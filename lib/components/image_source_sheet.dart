import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({required this.onImageSelected});

  final Function(File) onImageSelected;

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: ((context) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () async {
                    final file =
                        await picker.pickImage(source: ImageSource.camera);

                    onImageSelected(File(file!.path));
                  },
                  child: Text(
                    'Câmera',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final file =
                        await picker.pickImage(source: ImageSource.gallery);
                    onImageSelected(File(file!.path));
                  },
                  child: Text(
                    'Galeria',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ])),
    );
  }
}
