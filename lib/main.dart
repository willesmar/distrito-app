import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './utils/globals.dart' as globals;
import './pages/msgs.dart' as mensagens;
import './pages/anuncios.dart' as anuncios;
import './pages/programa.dart' as programa;
import './pages/sobre.dart' as sobre;
import './pages/crm.dart' as crm;

void main() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF36424E), //Colors.lightBlueAccent[700],
        backgroundColor: Color(0xFFF3FDFE),
        bottomAppBarColor: Color(0xFF90979F),
      ),
      home: new MyTabs()));
}

class MyTabs extends StatefulWidget {
  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {
  TabController controller;
  String _igreja;
  SharedPreferences _prefs;

  Future getSharedPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString("igreja", "oliveira3");
    // _igreja = prefs.getString("igreja") ?? null;
    setState(() {
      _igreja = _prefs.getString("igreja") ?? null;
    });
  }

  Future<Null> _selecioneIgreja() async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: const Text('Selecione uma igreja!'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  debugPrint(_igreja);
                  Navigator.pop(context, 'jacy');
                },
                child: const ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text('IASD Jacy'),
                ),
                //const Text('IASD Jacy'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  debugPrint(_igreja);
                  Navigator.pop(context, 'oliveira3');
                },
                child:
                    //const Text('IASD Oliveira III'),
                    const ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text('IASD Oliveira III'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  debugPrint(_igreja);
                  Navigator.pop(context, 'piratininga');
                },
                child:
                    //const Text('IASD Piratininga'),
                    const ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text('IASD Piratininga'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  debugPrint(_igreja);
                  Navigator.pop(context, 'caicara');
                },
                child:
                    // const Text('IASD Caiçara'),
                    const ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text('IASD Caiçara'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  debugPrint(_igreja);
                  Navigator.pop(context, 'uniao');
                },
                child:
                    // const Text('IASD União'),
                    const ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text('IASD União'),
                ),
              ),
            ],
          );
        })) {
      case 'jacy':
        debugPrint('jacy');
        _prefs.setString("igreja", "jacy");
        globals.igreja = 'jacy';
        break;
      case 'oliveira3':
        debugPrint('ol3');
        _prefs.setString("igreja", "oliveira3");
        globals.igreja = 'oliveira3';
        break;
      case 'piratininga':
        debugPrint('piratininga');
        _prefs.setString("igreja", "piratininga");
        globals.igreja = 'piratininga';
        break;
      case 'caicara':
        debugPrint('caicara');
        _prefs.setString("igreja", "caicara");
        globals.igreja = 'caicara';
        break;
      case 'uniao':
        debugPrint('uniao');
        _prefs.setString("igreja", "uniao");
        globals.igreja = 'uniao';
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _igreja = null;
    getSharedPrefs();
    controller = new TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_igreja == null) {
      _selecioneIgreja();
    }
    return new Scaffold(
      bottomNavigationBar: new Material(
          color: Theme.of(context).primaryColor, //Colors.green[900],
          child: new TabBar(
            controller: controller,
            labelStyle: new TextStyle(fontSize: 9.0),
            indicatorWeight: 1.0,
            indicatorColor: Color(0xFF36424E),
            tabs: <Tab>[
              new Tab(
                icon: new Icon(Icons.speaker_notes),
                text: 'Mensagem',
              ),
              new Tab(
                icon: new Icon(Icons.report),
                text: 'CRM',
              ),
              new Tab(
                icon: new Icon(Icons.event_note),
                text: 'Anúncios',
              ),
              new Tab(
                icon: new Icon(Icons.local_activity),
                text: 'Programa',
              ),
              new Tab(
                icon: new Icon(Icons.location_city),
                text: 'Sobre',
              ),
            ],
          )),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new mensagens.Mensagens(),
          new crm.ComunhaoRelacionamentoMissao(),
          new anuncios.Anuncios(),
          new programa.Programa(),
          new sobre.Sobre(),
        ],
      ),
    );
  }
}
