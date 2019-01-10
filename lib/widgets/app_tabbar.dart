import 'package:flutter/material.dart';

class AppTabBar extends AppBar {

  AppTabBar({
    Key key,
    @required Widget title,
    @required BuildContext context,
    List<Widget> actions,
  }) : super(
          key: key,
          title: title,
          actions: actions,
          backgroundColor: Theme.of(context).primaryColor,
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.5 : 4.0,
          bottomOpacity:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.5 : 1.0,
        );
}
