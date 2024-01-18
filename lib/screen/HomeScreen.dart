import 'package:flutter/material.dart';
import '../webview/webviewexample.dart';
import 'HomeScreen1.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      // appBar:  AppBar(
      //   title:  const Text('首頁'),
      // ),
      body:  Center(
        // child:  Text('首頁'),
        //   child:WebViewExample()
          child:HomeScreen1()
      ),
    );
  }
}