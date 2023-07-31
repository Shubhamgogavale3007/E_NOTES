import 'package:flutter/material.dart';
import 'package:ui_e_notes/ui_screen.dart';

import 'navigator_key/navigator_key.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      navigatorKey: NavigatorKey.navigatorKey,
      home: UiScreen(),
    );
  }
}
