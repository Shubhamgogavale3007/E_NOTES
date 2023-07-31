import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_e_notes/add_data.dart';
import 'package:ui_e_notes/model/user_model.dart';

import 'db_helper/db_helper.dart';

class UiScreen extends StatefulWidget {
  const UiScreen({super.key});

  @override
  State<UiScreen> createState() => _UiScreenState();
}

class _UiScreenState extends State<UiScreen> with TickerProviderStateMixin {
  late TabController tabController;
  var dbHelper;
  bool isGridView = false;

  late List<Map<String, dynamic>> snapshot;
  UserModel uModel = UserModel();


  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
    isGridView = true;
    dbHelper = DbHelper();
    initData();
  }

  initData() async {
    dbHelper = DbHelper();
    snapshot = await DbHelper().fetchDataFromDB();
    setState(() {});
  }

  removeFromCart(int index) async {
    dbHelper = DbHelper();
    await dbHelper.deleteData(snapshot[index]['id']);
    initData();
  }


bool switchX = false;
  ThemeData dark = ThemeData(brightness: Brightness.dark,primaryColor: Colors.white);
  ThemeData light = ThemeData(brightness: Brightness.light,primaryColor: Colors.black);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: switchX?dark:light,
      home: Scaffold(
        floatingActionButton: InkWell(
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 40,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
              color: Colors.black,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddData()));
              },
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddData()));
          },
        ),

        appBar: AppBar(
          automaticallyImplyLeading: false,

          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                  child: IconButton(
                    icon: Icon(
                      switchX ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        switchX = !switchX;
                      });
                    },
                  ) /* Icon(
                  Icons.dashboard,
                  size: 30,
                  color: Colors.white,
                ),*/

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                  child: IconButton(
                icon: Icon(
                  isGridView ? Icons.format_list_bulleted : Icons.grid_view,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    isGridView = !isGridView;
                  });
                },
              ) /* Icon(
                  Icons.dashboard,
                  size: 30,
                  color: Colors.white,
                ),*/

                  ),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "My",
                  style: TextStyle(
                    fontFamily: 'lufga',
                    fontSize: 50,
                    /*fontWeight: FontWeight.w400,*/

                  ),
                ),
                const Text(
                  "Notes",
                  style: TextStyle(
                      fontFamily: 'lufga',
                      fontSize: 50,
                      fontWeight: FontWeight.w400,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: TabBar(
                      labelPadding: const EdgeInsets.only(left: 3, right: 3),
                      indicatorColor: Colors.transparent,
                      controller: tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      tabs: [
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey, width: 1)),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "All",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'lufga_thin',
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey, width: 1)),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Important",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'lufga_thin',
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey, width: 1)),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "To-do",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'lufga_thin',
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 30,
                ),
                /*SizedBox(
                  height: 276,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 50,
                            width: 170,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(50)),
                              color: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                children: [
                                  const Align(
                                      alignment: Alignment.topCenter,
                                      child: Icon(Icons.filter_list_outlined)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Image\nnotes",
                                        style: TextStyle(
                                            fontSize: 20, fontFamily: 'lufga'),
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.white30,
                                        radius: 25,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: const Icon(
                                            Icons.image_search_outlined,
                                            size: 20,
                                          ),
                                          color: Colors.white,
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Update 2h ago",
                                        style: TextStyle(
                                            fontSize: 10, fontFamily: 'lufga'),
                                      )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Image.asset(
                                    'asset/images/ts2.png',
                                    height: 150,
                                    alignment: Alignment.bottomCenter,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),*/
                isGridView
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30)),
                                color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${snapshot[index]['title']}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 23, fontFamily: 'lufga_bold'),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${snapshot[index]['notes']}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 15, fontFamily: 'lufga'),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Wrap(
                                          spacing: 10,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.white30,
                                              radius: 20,
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: const Icon(
                                                  Icons.edit,
                                                  size: 15,
                                                ),
                                                color: Colors.white,
                                                onPressed: () {},
                                              ),
                                            ),
                                            CircleAvatar(
                                              backgroundColor: Colors.white30,
                                              radius: 20,
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: const Icon(
                                                  Icons.delete_outlined,
                                                  size: 15,
                                                ),
                                                color: Colors.white,
                                                onPressed: () {
                                                  showAlertDialog(context, index);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30)),
                                color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${snapshot[index]['title']}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 25, fontFamily: 'lufga_bold'),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${snapshot[index]['notes']}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'lufga'),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Wrap(
                                          spacing: 10,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.white30,
                                              radius: 25,
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: const Icon(
                                                  Icons.edit,
                                                  size: 20,
                                                ),
                                                color: Colors.white,
                                                onPressed: () {},
                                              ),
                                            ),
                                            CircleAvatar(
                                              backgroundColor: Colors.white30,
                                              radius: 25,
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: const Icon(
                                                  Icons.delete_outlined,
                                                  size: 20,
                                                ),
                                                color: Colors.white,
                                                onPressed: () {
                                                  showAlertDialog(context, index);
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, int index) {
    // set up the buttons
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
    Widget deleteButton = InkWell(
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "Delete",
          style: TextStyle(fontSize: 20, fontFamily: 'lufga'),
        ),
      ),
      onTap: () {
        removeFromCart(index).then((value) {
          Navigator.pop(context);
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      /*  title: const Text("Log Out"),*/
      content: const Padding(
        padding: EdgeInsets.only(top: 20, bottom: 30),
        child: Text(
          "Are you sure you want to Delete?",
          style: TextStyle(fontSize: 20, fontFamily: 'lufga_bold'),
        ),
      ),
      actions: [
        cancelButton,
        deleteButton,
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
