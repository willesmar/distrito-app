import 'package:flutter/material.dart';
import './pages/msgs.dart' as mensagens;
import './pages/anuncios.dart' as anuncios;
import './pages/programa.dart' as programa;
import './pages/sobre.dart' as sobre;
import './pages/crm.dart' as crm;

void main() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent[700],
      ),
      home: new MyTabs()));
}

class MyTabs extends StatefulWidget {
  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new Material(
          color: Theme.of(context).primaryColor, //Colors.green[900],
          child: new TabBar(
            controller: controller,
            labelStyle: new TextStyle(fontSize: 9.0),
            indicatorColor: new Color(0xFFFFFFFF),
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
