import 'package:flutter/material.dart';
import '../model/login_model.dart';
import '../service/login_database_helper.dart';
class MineScreen extends StatelessWidget {
  const MineScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title:  const Text('我的'),
      ),
      body:  Center(
        child:  ElevatedButton(
            child:  const Text('登出'),
            onPressed: () async{
              List<Login>? result = await DatabaseHelper.getAllNotes();
              await DatabaseHelper.deleteNote(result![0]);
              Navigator.of(context).pushNamed('/'); //跳转到main.dart对routeName（'/'）的界面
            }),
      ),
    );
  }
}