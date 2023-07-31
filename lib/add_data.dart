import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_e_notes/ui_screen.dart';

import 'alert_dialog/alert_dialog.dart';
import 'db_helper/db_helper.dart';
import 'model/user_model.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  addData() async {
    String title = titleController.text;
    String notes = notesController.text;

    if (title.isEmpty) {
      alertDialog("Please Enter Title");
    } else if (notes.isEmpty) {
      alertDialog("Please Enter Note");
    } else {
      UserModel uModel = UserModel();

      uModel.title = title;
      uModel.notes = notes;

      dbHelper = DbHelper();
      await dbHelper.saveData(uModel).then((userData) {
        showAlertDialog(context);

      }).catchError((error) {
        alertDialog("Error: Data Save Fail--$error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: const Text(
          "Add Notes",
          style: TextStyle(
              fontSize: 20, fontFamily: 'lufga_bold', color: Colors.white),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: const Icon(
                    Icons.close_sharp,
                    color: Colors.white,
                    size: 30,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 30,
                    ),
                    onTap: () {
                      addData();
                    }),
              ),
            ],
          )
        ],
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              style:  TextStyle(
                  color: Colors.white, fontFamily: 'lufga_bold'),
              controller: titleController,
              decoration:  InputDecoration(
                  hintText: 'Title', border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'lufga_thin',
                ),
              ),

            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 3,
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              style: const TextStyle(color: Colors.white, fontFamily: 'lufga'),
              controller: notesController,
              decoration: const InputDecoration(
                  hintText: 'Start typing ...',    hintStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'lufga_thin',
              ),border: InputBorder.none),
            ),
          /*  TextField(
              controller: titleController,
              style: const TextStyle(
                  color: Colors.white, fontFamily: 'lufga_bold'),
              decoration: const InputDecoration(
                hintText: "Enter Title here",
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'lufga_thin',
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 3, //<-- SEE HERE
                    color: Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 3, //<-- SEE HERE
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TextField(
              controller: notesController,
              style: const TextStyle(color: Colors.white, fontFamily: 'lufga'),
              decoration: const InputDecoration(
                hintText: "Start typing ...",
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'lufga_thin',
                ),
                border: InputBorder.none,
              ),
            ),*/
            const SizedBox(
              height: 100,
            ),

          ],
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context) {
    // set up the buttons

    Widget okButton = InkWell(
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "OK",
          style: TextStyle(fontSize: 20, fontFamily: 'lufga'),
        ),
      ),
      onTap: () {
        Navigator.push(context,MaterialPageRoute(builder: (context) => UiScreen()));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      /*  title: const Text("Log Out"),*/
      content:  Padding(
        padding:  EdgeInsets.only(top: 20, bottom: 20),
        child: Text(
          "Successfully Saved",
          style: TextStyle(fontSize: 20, fontFamily: 'lufga_bold'),
        ),
      ),
      actions: [
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
}
