import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:distrito_app/utils/bloc_provider.dart';
import '../utils/globals.dart' as globals;

class IgrejaBloc implements BlocBase {
  String _igrejaPreferida;
  final _igrejaCtrl = BehaviorSubject<String>();
  Stream<String> get igrejaSelecionada => _igrejaCtrl.stream;
  Function(String) get addIgrejaSelecionada => _igrejaCtrl.sink.add;

  IgrejaBloc() {
    _igrejaCtrl.listen(_saveIgrejaPref);
    _getIgrejaPref();
  }

  @override
  void dispose() {
    _igrejaCtrl.close();
  }

  Future<Null> _saveIgrejaPref(String igreja) async {
    print('_saveIgrejaPref');
    final SharedPreferences prefs = await globals.sprefs;
    await prefs.setString('igreja', igreja);
  }

  Future<Null> _getIgrejaPref() async {
    print('_getIgrejaPref');
    final SharedPreferences prefs = await globals.sprefs;
    _igrejaPreferida = await prefs.getString('igreja');
    _igrejaCtrl.isClosed ? null : addIgrejaSelecionada(_igrejaPreferida);
  }
}
