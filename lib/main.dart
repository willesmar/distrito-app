import 'package:distrito_app/pages/distrito_app.dart';
import 'package:distrito_app/pages/restart_wdgt.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintPointersEnabled = true;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<String> listaIgrejas = [
    'jacy',
    'oliveira3',
    'piratininga',
    'caicara',
  ];
  // 'uniao',
  // 'aquarios',
  // 'nacoes',
  listaIgrejas.forEach((i) {
    _firebaseMessaging.unsubscribeFromTopic(i);
  });
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(RestartWidget(child: DistritoApp()));
  });
}
