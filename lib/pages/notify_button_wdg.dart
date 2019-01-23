import 'package:distrito_app/utils/bloc_provider.dart';
import 'package:distrito_app/utils/programa_notification_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificarButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _notify = false;
    final ProgramaNotificationBloc ntfBloc =
        BlocProvider.of<ProgramaNotificationBloc>(context);
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    Widget _iosButton(bool notify) {
      return CupertinoButton(
        color: Colors.transparent,
        minSize: 35.0,
        padding: EdgeInsets.all(0.0),
        child: notify
            ? Icon(
                IconData(0xf39b,
                    fontFamily: 'CupertinoIcons',
                    fontPackage: 'cupertino_icons'),
                size: 30.0)
            : Icon(
                IconData(0xf39a,
                    fontFamily: 'CupertinoIcons',
                    fontPackage: 'cupertino_icons'),
                size: 30.0),
        onPressed: () {
          _notify = !_notify;
          ntfBloc.notificarPrgrm(_notify);
        },
      );
    }

    Widget _androidButton(bool notify) {
      print('_androidButton');
      return IconButton(
        icon: notify
            ? Icon(Icons.notifications_active)
            : Icon(Icons.notifications_none),
        onPressed: () {
          _notify = !_notify;
          ntfBloc.notificarPrgrm(_notify);
        },
      );
    }

    return StreamBuilder<bool>(
      stream: ntfBloc.notificacaoPrgrm,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          print('hasData');
          _notify = snapshot?.data;
          print(_notify);
          return isIOS ? _iosButton(_notify) : _androidButton(_notify);
        } else {
          _notify = false;
          return isIOS ? _iosButton(_notify) : _androidButton(_notify);
        }
      },
    );
  }
}
