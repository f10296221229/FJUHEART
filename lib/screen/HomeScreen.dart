import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../webview/webviewexample.dart';
import 'HomeScreen1.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      // appBar:  AppBar(
      //   title:  const Text('首頁'),
      // ),
      body:  Container(
          // color: Color(int.parse("dfe6f0", radix: 16)).withAlpha(255),
        // child:  Text('首頁'),
        //   child:WebViewExample()
          child:const HomeScreen1()
      ),
    );
  }
}