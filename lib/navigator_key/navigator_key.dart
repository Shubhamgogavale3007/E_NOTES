import 'package:flutter/cupertino.dart';

class NavigatorKey {
  static final navigatorKey =
  GlobalKey<NavigatorState>(debugLabel: 'navigator');
  static final dropDownKey = GlobalKey(debugLabel: 'dropDown');
}

