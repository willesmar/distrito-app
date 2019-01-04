import 'package:distrito_app/utils/bloc_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/globals.dart' as globals;

class ProgramaNotificationBloc implements BlocBase {
  bool _notificar;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  final _notificarProgramaCtrl = BehaviorSubject<bool>();
  Stream<bool> get notificacaoPrgrm => _notificarProgramaCtrl.stream;
  Function(bool) get notificarPrgrm => _notificarProgramaCtrl.sink.add;

  ProgramaNotificationBloc() {
    _notificarProgramaCtrl.listen(_saveProgramaNotificacaoPreference);
    _getProgramaNotificacaoPreference();
  }

  @override
  void dispose() {
    _notificarProgramaCtrl.close();
  }

  Future<Null> _saveProgramaNotificacaoPreference(bool notify) async {
    final SharedPreferences prefs = await _sprefs;
    if (_notificar != notify) {
      _notificar = notify;
      await prefs.setBool('notificacaoPrograma', notify);
      if (notify == true) {
        await _firebaseMessaging.subscribeToTopic('programa-${globals.igreja}');
      } else if (notify == false) {
        await _firebaseMessaging.unsubscribeFromTopic('programa-${globals.igreja}');
      }
    }
  }

  Future<Null> _getProgramaNotificacaoPreference() async {
    final SharedPreferences prefs = await _sprefs;
    _notificar = await prefs.getBool('notificacaoPrograma');
    notificarPrgrm(_notificar);
  }
}
