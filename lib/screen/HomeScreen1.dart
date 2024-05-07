import 'dart:io';

import 'package:devtest01/screen/DataGrid.dart';
import 'package:devtest01/webview/webviewIndex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import '../Icon/MyFlutterApp.dart';
import '../model/login_model.dart';
import '../partition/GridBuilder.dart';
import '../partition/ListBuilder.dart';
import '../service/PostProvider.dart';
import '../service/login_database_helper.dart';
import '../webview/webviewexample.dart';
import 'ChartDataGrid.dart';
import 'ImagePickerDemo.dart';
import 'ImagePickerDemo1.dart';
import 'IndexScreen.dart';
import 'JsonDataGrid.dart';
import 'LoginScreen.dart';

class HomeScreen1 extends StatelessWidget {
  const HomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListTileSelectExample(),
    );
  }
}

class ListTileSelectExample extends StatefulWidget {
  const ListTileSelectExample({super.key});

  @override
  ListTileSelectExampleState createState() => ListTileSelectExampleState();
}

class ListTileSelectExampleState extends State<ListTileSelectExample> {
  bool _isGridMode = true;
  bool _selectMode = true;

  @override
  void initState() {
    // context.read<PostProvider>().AIData();
    super.initState();
  }

  void initializeSelection() {}

  Future<void> myAsyncMethod(BuildContext context) async {
    List<Login>? result = await DatabaseHelper.getAllNotes();
    await DatabaseHelper.deleteNote(result![0]);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
          return const LoginScreen();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text('AI示警系統',
              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
          leading:
          _selectMode ? IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  onPressed: () => {
                        setState(() {
                          _isGridMode = false;
                          _selectMode = false;
                        })
                      })
              : IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  onPressed: () => {
                        setState(() {
                          _isGridMode = true;
                          _selectMode = true;
                        })
                      }),
          actions: <Widget>[
            ElevatedButton(
                child: const Text('登出'),
                onPressed: ()  {

                  myAsyncMethod(context);
                  // List<Login>? result = await DatabaseHelper.getAllNotes();
                  // await DatabaseHelper.deleteNote(result![0]);
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (BuildContext context) {
                  //   return const LoginScreen();
                  // }));
                  // Navigator.of(context).pushNamed('/'); //跳转到main.dart对routeName（'/'）的界面
                }),
          ],
        ),
        body: _isGridMode ?
        const GridBuilder()
            : const ListBuilder());
  }
}




