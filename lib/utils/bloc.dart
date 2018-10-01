import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/globals.dart' as globals;

class Bloc {
  // extends Object with ValidatorsExample
  // final _mensagemController = StreamController<dynamic>.broadcast();
  final _igrejaCtrl = BehaviorSubject<String>();

  // Add data to Stream
  // _mensagemController.stream.transform(validateEmail)
  Stream<String> get igreja => _igrejaCtrl.stream;

  // Change Stream data
  Function(String) get selecionarIgreja => _igrejaCtrl.sink.add;

  Stream<QuerySnapshot> get mensagens => Firestore.instance
      .collection('distrito')
      .document(globals.igreja.isNotEmpty ? globals.igreja : 'jacy')
      .collection('mensagens')
      .where('publicado', isEqualTo: true)
      .snapshots();

  Stream<QuerySnapshot> get anuncios => Firestore.instance
      .collection('distrito')
      .document(globals.igreja.isNotEmpty ? globals.igreja : 'jacy')
      .collection('anuncios')
      .where('publicado', isEqualTo: true)
      .snapshots();

  Stream<QuerySnapshot> get programas => Firestore.instance
      .collection('distrito')
      .document(globals.igreja.isNotEmpty ? globals.igreja : 'jacy')
      .collection('programas')
      .where('publicado', isEqualTo: true)
      .snapshots();

  Stream<QuerySnapshot> get sobre => Firestore.instance
      .collection('distrito')
      .document(globals.igreja.isNotEmpty ? globals.igreja : 'jacy') // XXX:
      .collection('sobre')
      .snapshots();

  Bloc() {
    selecionarIgreja('');
  }

  submit() {
    final msg = _igrejaCtrl.value;
  }

  dispose() {
    _igrejaCtrl.close();
  }
}

// final bloc = Bloc();

//////
class Provider extends InheritedWidget {
  // Usar outro arquivo
  final bloc;

  Provider({Key key, Widget child})
      : bloc = Bloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static Bloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}

/////////
class ValidatorsExample {
  // Usar outro arquivo
  final validateEmail = StreamTransformer<String, dynamic>.fromHandlers(
      handleData: (email, sink) {
    if (email.contains('@'))
      sink.add(email);
    else
      sink.addError('Enter a valid email');
  });
}
