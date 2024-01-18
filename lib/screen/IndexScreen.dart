import 'package:devtest01/webview/webviewIndex.dart';
import 'package:flutter/material.dart';
class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // appBar:  AppBar(
      //   title:  const Text('首頁'),
      // ),
      body:  Center(
        // child:  Text('首頁'),
          child:WebViewIndex(
            url: "http://211.20.21.35:8080/fjuheart/MH200101/index",
          )
      ),
    );
  }
}