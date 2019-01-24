import 'package:distrito_app/pages/splashscreen.dart';
import 'package:distrito_app/pages/tabs_wdgt.dart';
import 'package:distrito_app/utils/bloc_provider.dart';
import 'package:distrito_app/utils/globals.dart' as globals;
import 'package:distrito_app/utils/igreja_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DistritoApp extends StatefulWidget {
  @override
  DistritoAppState createState() => new DistritoAppState();
}

class DistritoAppState extends State<DistritoApp> {
  String _igrejaPreferida;
  Widget _defaultHome = new SplashScreen();

  Future<String> _loadIgrejaPreferida() async {
    final SharedPreferences prefs = await globals.sprefs;
//    await prefs.remove('igreja');
    String _igreja = await prefs.getString('igreja');
    if (_igreja != null && _igreja.isNotEmpty) {
      _defaultHome = MyTabs(igreja: _igreja);
      print(_igreja);
    }
    print(_igreja);
    return _igreja;
  }

  @override
  void initState() {
    super.initState();
    _loadIgrejaPreferida().then((igreja) {
      setState(() {
        globals.igreja = igreja;
        _igrejaPreferida = igreja;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    // final ThemeData kIOSTheme = new ThemeData(
    //   primarySwatch: Colors.blue,
    //   primaryColor: Colors.grey[200],
    //   primaryColorBrightness: Brightness.light,
    // );

    final ThemeData kDefaultTheme = new ThemeData(
      primaryColor: Colors.blueGrey[500], //Color(0xFF003366), //Colors.lightBlueAccent[700],
      secondaryHeaderColor: Colors.blueGrey[100],
      backgroundColor: Color(0xFFF3FDFE),
      bottomAppBarColor: Colors.blueGrey[50],//Color(0xFF003366),
    );

    if (isIOS) {
      return BlocProvider<IgrejaBloc>(
        bloc: IgrejaBloc(),
        child: CupertinoApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          home: _defaultHome,
        ),
      );
    } else {
      return BlocProvider<IgrejaBloc>(
        bloc: IgrejaBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // debugShowMaterialGrid: true,
          theme: kDefaultTheme,
          home: _defaultHome,
        ),
      );
    }
  }
}
