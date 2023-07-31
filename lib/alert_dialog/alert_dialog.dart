import 'package:flutter/material.dart';

import '../navigator_key/navigator_key.dart';

alertDialog(String msg) {
  //Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //Toast.show(msg, duration: Toast.lengthShort, gravity: Toast.bottom);
  showAlertDialog(NavigatorKey.navigatorKey.currentContext!, msg);
}

showAlertDialog(BuildContext context, String msg) {
  // set up the button
  Widget cancelButton = InkWell(
    child: const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "Cancel",
        style: TextStyle(fontSize: 20, fontFamily: 'lufga'),
      ),
    ),
    onTap: () {
      Navigator.pop(context);
    },
  );
  Widget okButton = InkWell(
    child: const Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        "OK",
        style: TextStyle(fontSize: 20, fontFamily: 'lufga'),
      ),
    ),
    onTap: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    title: const Text(
      "ALERT!",
      style: TextStyle(
          fontSize: 20, fontFamily: 'lufga_bold', color: Colors.black),
    ),
    content: Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Text(
        msg,
        style: TextStyle(
            fontSize: 20, fontFamily: 'lufga_bold', color: Colors.black),
      ),
    ),
    actions: [
      cancelButton,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
