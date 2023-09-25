// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:geolocator/geolocator.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String adArea = '';
  String subAdArea = '';

  StreamSubscription<Position>? positionStream;
  String status = 'Aguardando GPS';
  Position? positionLocation;

  @override
  void initState() {
    listenPosition();
    super.initState();
  }

  listenPosition() async {
    ph.PermissionStatus permission = await ph.Permission.location.request();

    if (permission.isDenied) {
      _showMessage(
          'Parece que você não permitiu o uso do GPS, abra as configurações do aplicativo e libere a permissão');
    } else {
      bool gpsIsEnabled = await Geolocator.isLocationServiceEnabled();

      if (!gpsIsEnabled) {
        _showMessage(
            'Seu GPS está desligado, para obter a localicação ative-o.');
      }

      setState(() {
        status = 'Obtendo a localização';
      });

      positionStream =
          Geolocator.getPositionStream().listen((Position position) async {
        // garante que o trecho abaixo seja executado somente uma vez

        if (positionLocation == null) {
          positionLocation = position;

          List<Placemark> locations = await placemarkFromCoordinates(
              positionLocation!.latitude, positionLocation!.longitude);

          adArea = locations[0].administrativeArea!;
          subAdArea = locations[0].subAdministrativeArea!;

          setState(() {
            status = 'Localização obtida';
          });
        }
      });
    }
  }

  _showMessage(String message) => formKey.currentState!.validate()
      ? ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            behavior: SnackBarBehavior.floating,
          ),
        )
      : '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          key: formKey,
          child: positionLocation != null
              ? Text(
                  '${adArea}, ${subAdArea}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )
              : const Text('')),
    );
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }
}
