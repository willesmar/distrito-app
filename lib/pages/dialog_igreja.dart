import 'package:flutter/material.dart';

class DialogIgreja extends StatefulWidget {
  const DialogIgreja();
  @override
  State<StatefulWidget> createState() => new DialogIgrejaState();
}

class DialogIgrejaState extends State<DialogIgreja> {
  String _igreja;
  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: const Text('Selecione uma igreja!'),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () {
            debugPrint(_igreja);
            Navigator.pop(context, 'jacy');
          },
          child: Container(
            height: 40.0,
            child: const ListTile(
              leading: Image(
                image: AssetImage('assets/images/simbolo_iasd.png'),
                width: 28.0,
                height: 25.0,
              ),
              // CircleAvatar(
              //   backgroundColor: Colors.transparent,
              //   backgroundImage:
              //       AssetImage('assets/images/simbolo_iasd.png'),
              // ),
              title: Text('IASD Jacy'),
            ),
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            debugPrint(_igreja);
            Navigator.pop(context, 'oliveira3');
          },
          child: Container(
            height: 40.0,
            child: const ListTile(
              leading: Image(
                image: AssetImage('assets/images/simbolo_iasd.png'),
                width: 28.0,
                height: 25.0,
              ),
              title: Text('IASD Oliveira III'),
            ),
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            debugPrint(_igreja);
            Navigator.pop(context, 'piratininga');
          },
          child: Container(
            height: 40.0,
            child: const ListTile(
              leading: Image(
                image: AssetImage('assets/images/simbolo_iasd.png'),
                width: 28.0,
                height: 25.0,
              ),
              title: Text('IASD Piratininga'),
            ),
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            debugPrint(_igreja);
            Navigator.pop(context, 'caicara');
          },
          child: Container(
            height: 40.0,
            child: const ListTile(
              leading: Image(
                image: AssetImage('assets/images/simbolo_iasd.png'),
                width: 28.0,
                height: 25.0,
              ),
              title: Text('IASD Caiçara'),
            ),
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            debugPrint(_igreja);
            Navigator.pop(context, 'uniao');
          },
          child: Container(
            height: 40.0,
            child: const ListTile(
              leading: Image(
                image: AssetImage('assets/images/simbolo_iasd.png'),
                width: 28.0,
                height: 25.0,
              ),
              title: Text('IASD União'),
            ),
          ),
        ),
      ],
    );
  }
}
