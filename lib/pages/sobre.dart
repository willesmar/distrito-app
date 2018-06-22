import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Sobre'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: new ListView(children: <Widget>[
        new Container(
          constraints: new BoxConstraints.expand(
            height: 300.0,
          ),
          child: new Stack(fit: StackFit.expand, children: <Widget>[
            new Image.asset(
              'assets/images/iasd_ol3.jpg',
              fit: BoxFit.cover,
            ),
            new Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: new Container(
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ]),
                ),
                padding: const EdgeInsets.all(18.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Expanded(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(
                            'IASD OLIVEIRA III',
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
        Text('data'),
      ]),
    );
  }
}
