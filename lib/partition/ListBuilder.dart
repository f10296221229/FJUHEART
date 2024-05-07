import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Icon/MyFlutterApp.dart';
import '../screen/ChartDataGrid.dart';
import '../screen/HomeScreen.dart';
import '../screen/HomeScreen1.dart';
import '../screen/JsonDataGrid.dart';
import '../screen/LoginScreen.dart';
import '../webview/webviewIndex.dart';

class ListBuilder extends StatefulWidget {
  const ListBuilder({
    super.key,
  });
  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        color: Color(int.parse("dfe6f0", radix: 16)).withAlpha(255),
        child: ListView(
          children: <Widget>[
            PopScope(
              canPop: false,
              onPopInvoked: (didPop) {
                if (didPop) {
                  return;
                }
                // _navigateAndDisplaySelection(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const HomeScreen();
                    }));
                // logic
              },
              child: const Divider(height: 0,),
            ),

            SizedBox(
              child: ListTile(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return JsonDataGrid(Measure_s: '', Measure_e: '');
                        }));
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (BuildContext context) {
                    //       return WebViewIndex(
                    //         url: "http://211.20.21.35:8080/fjuheart/MH200101/index",
                    //       );
                    //     }));
                  },
                  title: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        MyFlutterApp.input,
                        color: Color.fromRGBO(244, 54, 98, 1.0),
                      ),
                      Text('生理指標輸入'),
                    ],
                  )),
            ),
            const Divider(
              height: 0,
            ),
            SizedBox(
              // height: 30,
              // color: Colors.amber[500],
              child: ListTile(
                  onTap: () {

                    //flutter
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return  const ChartDataGrid(Ms: '', Me: '', type: 'M00001', typeName: '體溫',);
                        }));
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (BuildContext context) {
                    //       return WebViewIndex(
                    //         url: "http://211.20.21.35:8080/fjuheart/MH200102/index",
                    //       );
                    //     }));
                  },
                  title: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(MyFlutterApp.thermometer),
                      Text('體溫'),
                    ],
                  )),
            ),
            const Divider(
              height: 0,
            ),
            SizedBox(
              child: ListTile(
                  onTap: () {

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return  const ChartDataGrid(Ms: '', Me: '', type: 'M00002', typeName: '心跳',);
                        }));
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (BuildContext context) {
                    //       return WebViewIndex(
                    //         url: "http://211.20.21.35:8080/fjuheart/MH200103/index",
                    //       );
                    //     }));
                  },
                  title: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(MyFlutterApp.heart_rate),
                      Text('心跳'),
                    ],
                  )),
            ),
            const Divider(
              height: 0,
            ),
            SizedBox(
              // height: 30,
              // color: Colors.amber[100],
              child: ListTile(
                  onTap: () {

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return  const ChartDataGrid(Ms: '', Me: '', type: 'M00003', typeName: '呼吸',);
                        }));
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (BuildContext context) {
                    //       return WebViewIndex(
                    //         url: "http://211.20.21.35:8080/fjuheart/MH200104/index",
                    //       );
                    //     }));
                  },
                  title: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(MyFlutterApp.breathing),
                      Text('呼吸'),
                    ],
                  )),
            ),
            const Divider(
              height: 0,
            ),
            SizedBox(
              // height: 30,
              // color: Colors.amber[100],
              child: ListTile(
                  onTap: () {

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return  const ChartDataGrid(Ms: '', Me: '', type: 'M00004', typeName: '血壓',);
                        }));
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (BuildContext context) {
                    //       return WebViewIndex(
                    //         url: "http://211.20.21.35:8080/fjuheart/MH200105/index",
                    //       );
                    //     }));
                  },
                  title: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(MyFlutterApp.hypertension),
                      Text('血壓'),
                    ],
                  )),
            ),
            const Divider(
              height: 0,
            ),
            SizedBox(
              // height: 30,
              // color: Colors.amber[100],
              child: ListTile(
                  onTap: () {

                    //flutter
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return  const ChartDataGrid(Ms: '', Me: '', type: 'M00005', typeName: '血氧(SPO2)',);
                        }));
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (BuildContext context) {
                    //       return WebViewIndex(
                    //         url: "http://211.20.21.35:8080/fjuheart/MH200106/index",
                    //       );
                    //     }));
                  },
                  title: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(MyFlutterApp.oxygen_saturation),
                      Text('血氧'),
                    ],
                  )),
            ),
            const Divider(
              height: 0,
            ),
            SizedBox(
              // height: 30,
              // color: Colors.amber[100],
              child: ListTile(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return WebViewIndex(
                            url: "http://211.20.21.35:8080/fjuheart/MH200110/index",
                          );
                        }));
                  },
                  title: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(MyFlutterApp.input),
                      Text('AI小幫手'),
                    ],
                  )),
            ),
            const Divider(
              height: 0,
            ),
            SizedBox(
              // height: 30,
              // color: Colors.amber[100],
              child: ListTile(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const HomeScreen1();
                        }));
                  },
                  title: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(MyFlutterApp.menu),
                      Text('回首頁'),
                    ],
                  )),
            ),
            const Divider(
              height: 0,
            ),
            SizedBox(
              child: ListTile(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const LoginScreen();
                        }));
                  },
                  title: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(MyFlutterApp.power_button),
                      Text('登出'),
                    ],
                  )),
            ),
          ],
        ),
      )

      ;
  }
}