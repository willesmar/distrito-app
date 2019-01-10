import 'package:distrito_app/utils/bloc_provider.dart';
import 'package:distrito_app/utils/programa_notification_bloc.dart';
import 'package:flutter/material.dart';

class NotificarButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _notify = false;
    final ProgramaNotificationBloc ntfBloc =
        BlocProvider.of<ProgramaNotificationBloc>(context);

    return StreamBuilder<bool>(
      stream: ntfBloc.notificacaoPrgrm,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          _notify = snapshot?.data;
          return IconButton(
            icon: snapshot?.data == true
                ? Icon(Icons.notifications_active)
                : Icon(Icons.notifications_none),
            onPressed: () {
              _notify = !_notify;
              ntfBloc.notificarPrgrm(_notify);
            },
          );
        }
        return Container(color: Colors.greenAccent,);
      },
    );
  }
}
