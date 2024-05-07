import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screen/AIDataGrid.dart';
import '../screen/ChartDataGrid.dart';
import '../screen/JsonDataGrid.dart';
import '../webview/webviewIndex.dart';

class GridBuilder extends StatefulWidget {
  const GridBuilder({
    super.key,
  });

  @override
  State<GridBuilder> createState() => _GridBuilderState();
}
class _GridBuilderState extends State<GridBuilder> {
  DateTime? _lastPressedAt;

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        // color: Color(int.parse("dfe6f0", radix: 16)).withAlpha(255),
        // child: Builder(builder: (BuildContext context) {
        //   return "";
        // },
        child: ListView(

          children: <Widget>[
            PopScope(
              canPop: false,
              onPopInvoked: (didPop) {
                if (didPop) {
                  return;
                }
                if (_lastPressedAt == null ||
                    DateTime.now().difference(_lastPressedAt!) > const Duration(seconds: 1)) {
                  //两次点击间隔超过1秒则重新计时
                  _lastPressedAt = DateTime.now();

                  // Navigator.pop(context);
                }else{
                  SystemNavigator.pop();
                  _lastPressedAt =null;
                }
              },
              child: const Text(''),
            ),
            InkWell(

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
              child: Ink.image(
                  width: 300,
                  height: 150,
                  image: const NetworkImage(
                    'http://211.20.21.35:8080/fjuheart/resources/images/btn0.png',
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {

                    //flutter
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return  const ChartDataGrid(Ms: '', Me: '', type: 'M00001', typeName: '體溫',);
                        }));

                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {return WebViewIndex(
                    //       url: "http://211.20.21.35:8080/fjuheart/MH200102/index",);}));
                  },
                  child: Ink.image(
                      width: 120,
                      height: 120,
                      image: const NetworkImage(
                        'http://211.20.21.35:8080/fjuheart/resources/images/btn7.png',
                      )),
                ),
                InkWell(
                  onTap: () {
                    //flutter
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return  const ChartDataGrid(Ms: '', Me: '', type: 'M00002', typeName: '心跳',);
                        }));
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                    //       return WebViewIndex(url: "http://211.20.21.35:8080/fjuheart/MH200103/index",);}));
                  },
                  child: Ink.image(
                      width: 120,
                      height: 120,
                      image: const NetworkImage(
                        'http://211.20.21.35:8080/fjuheart/resources/images/btn3.png',
                      )),
                ),
                InkWell(
                  onTap: () {
                    //flutter
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return  const ChartDataGrid(Ms: '', Me: '', type: 'M00003', typeName: '呼吸',);
                        }));
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                    //       return WebViewIndex(url: "http://211.20.21.35:8080/fjuheart/MH200104/index",);}));
                  },
                  child: Ink.image(
                      width: 120,
                      height: 120,
                      image: const NetworkImage(
                        'http://211.20.21.35:8080/fjuheart/resources/images/btn6.png',
                      )),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //血壓
                InkWell(
                  onTap: () {

                    //flutter
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return  const ChartDataGrid(Ms: '', Me: '', type: 'M00004', typeName: '血壓',);
                        }));

                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                    //       return WebViewIndex(url: "http://211.20.21.35:8080/fjuheart/MH200105/index",);}));
                  },
                  child: Ink.image(
                      width: 120,
                      height: 120,
                      image: const NetworkImage(
                        'http://211.20.21.35:8080/fjuheart/resources/images/btn5.png',
                      )),
                ),
                //血氧
                InkWell(
                  onTap: () {

                    //flutter
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return  const ChartDataGrid(Ms: '', Me: '', type: 'M00005', typeName: '血氧(SPO2)',);
                        }));
                    //webview
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                    //       return WebViewIndex(url: "http://211.20.21.35:8080/fjuheart/MH200106/index",);
                    //     }));
                  },
                  child: Ink.image(
                      width: 120,
                      height: 120,
                      image: const NetworkImage(
                        'http://211.20.21.35:8080/fjuheart/resources/images/btn4.png',
                      )),
                ),
              ],
            ),
            //AI小幫手
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      // return  const NewGraphWidget(Ms: '', Me: '', type: 'M00001', typeName: '體溫',);
                      return  const AIDataGrid(Ms: '', Me: '', type: '', typeName: 'AI小幫手',);
                    }));

                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (BuildContext context) {
                //       return WebViewIndex(
                //         url: "http://211.20.21.35:8080/fjuheart/MH200110/index",
                //       );
                //     }));
              },
              child: Ink.image(
                  width: 300,
                  height: 150,
                  image: const NetworkImage(
                    'http://211.20.21.35:8080/fjuheart/resources/images/btn15.png',
                  )),
            ),

            // InkWell(
            //   onTap: () {
            //
            //     // context.read<PostProvider>().AIData();
            //
            //     Navigator.pushReplacement(context,
            //         MaterialPageRoute(builder: (BuildContext context) {
            //           // return  const NewGraphWidget(Ms: '', Me: '', type: 'M00001', typeName: '體溫',);
            //           return  const AIDataGrid(Ms: '', Me: '', type: '', typeName: 'AI小幫手',);
            //         }));
            //   },
            //   child: Ink.image(
            //       width: 300,
            //       height: 150,
            //       image: const NetworkImage(
            //         'http://211.20.21.35:8080/fjuheart/resources/images/btn14.png',
            //       )),
            // ),

            // InkWell(
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (BuildContext context) {
            //           return   const ImagePickerDemo();
            //         }));
            //   },
            //   child: Ink.image(
            //       width: 300,
            //       height: 150,
            //       image: const NetworkImage(
            //         'http://211.20.21.35:8080/fjuheart/resources/images/btn13.png',
            //       )),
            // ),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (BuildContext context) {
            //           return  ImagePickerDemo1(title: 'Flutter Image Upload Demo',);
            //         }));
            //   },
            //   child: Ink.image(
            //       width: 300,
            //       height: 150,
            //       image: const NetworkImage(
            //         // 'http://localhost:8080/devmvc/resources/images/btn12.png',
            //         'http://211.20.21.35:8080/fjuheart/resources/images/btn12.png',
            //       )),
            // ),
          ],
        ),
      );
  }
}