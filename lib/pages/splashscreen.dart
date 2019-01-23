import 'dart:ui';

import 'package:distrito_app/model/igreja.dart';
import 'package:distrito_app/pages/tabs_wdgt.dart';
import 'package:distrito_app/utils/bloc_provider.dart';
import 'package:distrito_app/utils/globals.dart' as globals;
import 'package:distrito_app/utils/igreja_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const TextStyle textStyle = TextStyle(color: Colors.white);

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<Igreja> _igrejas = [
    new Igreja(igreja: 'IASD Vila Jacy', valor: 'jacy'),
    new Igreja(igreja: 'IASD Oliveira 3', valor: 'oliveira3'),
    new Igreja(igreja: 'IASD Piratininga', valor: 'piratininga'),
    new Igreja(igreja: 'IASD Caiçara', valor: 'caicara'),
  ];
  // new Igreja(igreja: 'Grupo União', valor: 'uniao'),
  // new Igreja(igreja: 'Grupo Aquários', valor: 'aquarios'),
  // new Igreja(igreja: 'Grupo Nações', valor: 'nacoes'),
  // List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentIgreja;

  @override
  void initState() {
    super.initState();
  }

  final Widget background = Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.2), BlendMode.darken),
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
    'assets/images/simbolo_iasd_nome.png',
//    'assets/images/circular.png',
    width: 280.0,
    height: 280.0,
  );

  final Widget description = Text(
    'Escolha sua igreja',
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
          hint: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: description,
          ), //Text('Escolha sua igreja'),
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
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return isIOS ? _iosSplash(context) : _androidSplash(context);
  }

  Scaffold _androidSplash(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                        SizedBox(
                          height: 15.0,
                        ),
                        dropdownInput(context),
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

  Future<String> checkIgreja() async {
    final SharedPreferences prefs = await globals.sprefs;
    return prefs.getString('igreja');
    // prefs.setString('igreja', 'oliveira3');
  }

  Scaffold _iosSplash(BuildContext context) {
    final IgrejaBloc igrejaBloc = BlocProvider.of<IgrejaBloc>(context);
    return Scaffold(
      body: CupertinoPageScaffold(
        child: Builder(
          builder: (context) => Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  background,
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          logo,
                          SizedBox(
                            height: 45.0,
                          ),
                          StreamBuilder(
                            stream: igrejaBloc.igrejaSelecionada,
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snap) {
                              if (!snap.hasData) {
                                // return CupertinoActivityIndicator();
                                return _actionSheetIgreja(context);
                              }
                              return CupertinoButton(
                                child: Text(
                                  snap.data,
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: CupertinoColors.activeBlue),
                                ),
                                color: CupertinoColors.lightBackgroundGray,
                                onPressed: () {
                                  _goToTabs(snap.data);
                                },
                              );
                              // _goToTabs(snap.data);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }

  Container _actionSheetIgreja(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              containerForSheet<String>(
                context: context,
                child: CupertinoActionSheet(
                    title: const Text(
                      'Escolha uma igreja',
                      style: TextStyle(fontSize: 22.0),
                    ),
                    // message: const Text(
                    //     'Your options are '),
                    actions: _actionOptions(context),
                    cancelButton: CupertinoActionSheetAction(
                      child: const Text('Cancelar'),
                      isDefaultAction: true,
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop('Cancel');
                      },
                    )),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                // color: CupertinoColors.tr,
                border: Border(
                  top: BorderSide(color: CupertinoColors.white, width: 0.0),
                  bottom: BorderSide(color: CupertinoColors.white, width: 0.0),
                ),
              ),
              height: 54.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SafeArea(
                  top: false,
                  bottom: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // const Text('Escolha uma igreja', style: TextStyle(fontSize: 18.0, color: CupertinoColors.inactiveGray),),
                      Text(
                        'Selecione',
                        style: TextStyle(
                            fontSize: 22.0, color: CupertinoColors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _actionOptions(BuildContext context) {
    List<Widget> opt = [];
    _igrejas.forEach((f) {
      opt.add(
        CupertinoActionSheetAction(
          child: Text(f.igreja),
          onPressed: () {
            Navigator.pop(context, f.valor);
          },
        ),
      );
    });
    return opt.toList();
  }

  void containerForSheet<T>({BuildContext context, Widget child}) {
    showCupertinoModalPopup<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // Scaffold.of(context).showSnackBar(new SnackBar(
      //   content: new Text('You clicked $value'),
      //   duration: Duration(milliseconds: 800),
      // ));
      // setState(() {
      //   _currentIgreja = value.toString();
      // });
      print('container for sheet ${value.toString()}');
      if (value.toString() == 'Cancel' || value == null) return null;
      _goToTabs(value.toString());
    });
  }

  void _goToTabs(value) async {
    final SharedPreferences prefs = await globals.sprefs;
    setState(() {
      _currentIgreja = value.toString();
    });
    globals.igreja = value.toString();
    prefs.setString('igreja', value);
//    print(_currentIgreja);
//    print(globals.igreja);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MyTabs(igreja: value.toString())));
  }
}
