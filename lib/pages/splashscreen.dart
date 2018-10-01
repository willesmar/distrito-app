import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:distrito_app/pages/tabs_wdgt.dart';
import '../utils/globals.dart' as globals;

const TextStyle textStyle = TextStyle(color: Colors.white);

class Igreja {
  final String igreja;
  final String valor;

  Igreja({this.igreja, this.valor});
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // new Igreja(igreja: 'Selecione', valor: ''),
  List<Igreja> _igrejas = [
    new Igreja(igreja: 'IASD Vila Jacy', valor: 'jacy'),
    new Igreja(igreja: 'IASD Oliveira 3', valor: 'oliveira3'),
    new Igreja(igreja: 'IASD Piratininga', valor: 'piratininga'),
    new Igreja(igreja: 'IASD Caiçara', valor: 'caicara'),
    new Igreja(igreja: 'Grupo União', valor: 'uniao'),
    new Igreja(igreja: 'Grupo Aquários', valor: 'aquarios'),
    new Igreja(igreja: 'Grupo Nações', valor: 'nacoes'),
  ];
  // List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentIgreja;

  @override
  void initState() {
    // _dropDownMenuItems = getDropDownMenuItems();
    // _currentIgreja = _dropDownMenuItems[0].value;
    super.initState();
  }

  // List<DropdownMenuItem<String>> getDropDownMenuItems() {
  //   List<DropdownMenuItem<String>> items = new List();
  //   for (Igreja igreja in _igrejas) {
  //     items.add(new DropdownMenuItem(
  //         value: igreja.valor, child: new Text(igreja.igreja)));
  //   }
  //   return items;
  // }

  // Widget dropdownButton() {
  //   return DropdownButton(
  //     value: _currentIgreja,
  //     items: _dropDownMenuItems,
  //     onChanged: changedDropDownItem,
  //   );
  // }

  // void changedDropDownItem(String selectedIgreja) {
  //   print(selectedIgreja);
  //   setState(() {
  //     _currentIgreja = selectedIgreja;
  //   });
  // }

  final Widget background = Container(
    decoration: BoxDecoration(
      // color: const Color(0xFFE3F2FD),
      image: DecorationImage(
        fit: BoxFit.cover,
        // colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
        image: AssetImage('assets/images/splash-bg.jpg'),
      ),
    ),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Container(
        decoration: new BoxDecoration(color: Colors.black.withOpacity(0.0)),
      ),
    ),
  );

  final Widget blueOpacity = Container(
    color: Color(0xFFE3F2FD).withOpacity(0.5),
  );

  final Widget logo = Image.asset(
    'assets/images/circular.png',
    width: 180.0,
    height: 180.0,
  );

  final Widget description = Text(
    'Escolha sua igreja.',
    textAlign: TextAlign.center,
    style: textStyle.copyWith(fontSize: 24.0, color: Color(0xFF003366)),
  );

  Widget button(String label, Function onTap) {
    return Material(
      color: Color(0xFF003366),
      borderRadius: BorderRadius.circular(30.0),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.white24,
        highlightColor: Colors.white10,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 13.0),
          child: Center(
            child: Text(
              label,
              style: textStyle.copyWith(fontSize: 18.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget dropdownInput(BuildContext context) {
    // final bloc = Provider.of(context);
    return InputDecorator(
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        filled: true,
        fillColor: Colors.white,
      ),
      isEmpty: _currentIgreja == '',
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _currentIgreja,
          isDense: true,
          onChanged: (String igreja) {
            setState(() {
              _currentIgreja = igreja;
            });
            globals.igreja = igreja;
            print(_currentIgreja);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => MyTabs(igreja: _currentIgreja)));
            // bloc.selecionarIgreja(igreja);
          },
          items: _igrejas.map((Igreja igreja) {
            return DropdownMenuItem<String>(
              value: igreja.valor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  igreja.igreja,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF003366),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          background,
          // blueOpacity,
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  logo,
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        description,
                        SizedBox(
                          height: 15.0,
                        ),
                        // dropdownButton(),
                        dropdownInput(context),
                        SizedBox(
                          height: 15.0,
                        ),
                        // button('Entrar', () {
                        //   print('<<<<<< entrar btn >>>>>');
                        //   if (_currentIgreja.isNotEmpty) {
                        //     print(_currentIgreja);
                        //     Navigator.of(context).pushReplacement(
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 MyTabs(igreja: _currentIgreja)));
                        //   }
                        //   // bloc.igreja.listen((hasIgreja) async {
                        //   //   if (hasIgreja.length > 1 && _currentIgreja != null &&
                        //   //       hasIgreja == _currentIgreja) {
                        //   //     print(
                        //   //         'Igreja => $hasIgreja e _currentIgreja $_currentIgreja');
                        //   //     // await selecionarIgrejaModal(context);
                        //   //   }
                        //   // });
                        // }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
