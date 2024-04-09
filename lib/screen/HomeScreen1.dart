import 'dart:io';

import 'package:devtest01/screen/DataGrid.dart';
import 'package:devtest01/webview/webviewIndex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import '../Icon/MyFlutterApp.dart';
import '../model/login_model.dart';
import '../service/login_database_helper.dart';
import '../webview/webviewexample.dart';
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
    super.initState();
  }

  void initializeSelection() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text('AI示警系統',
              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
          leading: _selectMode
              ? IconButton(
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
                onPressed: () async {
                  List<Login>? result = await DatabaseHelper.getAllNotes();
                  await DatabaseHelper.deleteNote(result![0]);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const LoginScreen();
                  }));
                  // Navigator.of(context).pushNamed('/'); //跳转到main.dart对routeName（'/'）的界面
                }),
          ],
        ),
        body: _isGridMode ? const GridBuilder() : const ListBuilder());
  }
}

class GridBuilder extends StatefulWidget {
  const GridBuilder({
    super.key,
    // required this.selectedList,
    // required this.isSelectionMode,
    // required this.onSelectionChange,
  });

  // final bool isSelectionMode;
  // final ValueChanged<bool>? onSelectionChange;
  // final List<bool> selectedList;

  @override
  GridBuilderState createState() => GridBuilderState();
}

class GridBuilderState extends State<GridBuilder> {
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop) {
             return;
            }


            // print("_lastPressedAt");
            // print(_lastPressedAt);
            // exit(0);
            // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            // Navigator.pop(context);
            if (_lastPressedAt == null ||
                DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 1)) {
              //两次点击间隔超过1秒则重新计时
              _lastPressedAt = DateTime.now();

              // Navigator.pop(context);
            }else{
              SystemNavigator.pop();
              _lastPressedAt =null;
            }
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (BuildContext context) {
            //       return   const HomeScreen1();
            //     }));
            // logic
          },
          child: Text(''),
        ),

        InkWell(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return JsonDataGrid(Measure_s: '', Measure_e: '');
            }));
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (BuildContext context) {
            //       return  WebViewIndex(
            //         url: "http://211.20.21.35:8080/fjuheart/MH200101/index",
            //       );
            // }));
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return WebViewIndex(
                    url: "http://211.20.21.35:8080/fjuheart/MH200102/index",
                  );
                }));
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return WebViewIndex(
                    url: "http://211.20.21.35:8080/fjuheart/MH200103/index",
                  );
                }));
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return WebViewIndex(
                    url: "http://211.20.21.35:8080/fjuheart/MH200104/index",
                  );
                }));
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
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return WebViewIndex(
                    url: "http://211.20.21.35:8080/fjuheart/MH200105/index",
                  );
                }));
              },
              child: Ink.image(
                  width: 120,
                  height: 120,
                  image: const NetworkImage(
                    'http://211.20.21.35:8080/fjuheart/resources/images/btn5.png',
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return WebViewIndex(
                    url: "http://211.20.21.35:8080/fjuheart/MH200106/index",
                  );
                }));
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
        InkWell(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return WebViewIndex(
                url: "http://211.20.21.35:8080/fjuheart/MH200110/index",
              );
            }));
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
        //     Navigator.pushReplacement(context,
        //         MaterialPageRoute(builder: (BuildContext context) {
        //           return   JsonDataGrid(Measure_s: '', Measure_e: '');
        //         }));
        //     // Navigator.push(context,
        //     //     MaterialPageRoute(builder: (BuildContext context) {
        //     //       return  WebViewIndex(
        //     //         url: "http://211.20.21.35:8080/fjuheart/MH200110/index",
        //     //       );
        //     //     }));
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
    );
  }
}

class ListBuilder extends StatefulWidget {
  const ListBuilder({
    super.key,
    // required this.selectedList,
    // required this.isSelectionMode,
    // required this.onSelectionChange,
  });

  // final bool isSelectionMode;
  // final List<bool> selectedList;
  // final ValueChanged<bool>? onSelectionChange;

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  // void _toggle(int index) {
  //   if (widget.isSelectionMode) {
  //     setState(() {
  //       widget.selectedList[index] = !widget.selectedList[index];
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return WebViewIndex(
                    url: "http://211.20.21.35:8080/fjuheart/MH200102/index",
                  );
                }));
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
                  return WebViewIndex(
                    url: "http://211.20.21.35:8080/fjuheart/MH200103/index",
                  );
                }));
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
                  return WebViewIndex(
                    url: "http://211.20.21.35:8080/fjuheart/MH200104/index",
                  );
                }));
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
                  return WebViewIndex(
                    url: "http://211.20.21.35:8080/fjuheart/MH200105/index",
                  );
                }));
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return WebViewIndex(
                    url: "http://211.20.21.35:8080/fjuheart/MH200106/index",
                  );
                }));
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
          // height: 30,
          // color: Colors.amber[100],
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
        //  Image.asset(
        //   'images/lake.jpg',
        //   width: 600,
        //   height: 240,
        //   //cover(充满容器)、fill（充满父容器）、contain（总有宽或高跟父一样）、none(原图居中显示)、fitWidth（宽度跟父一样）、fitHeight（高度跟父一样）
        //   fit: BoxFit.contain,
        // ),
        // TextSection(),
        // LoginButton(),
        // ForgetButton()
      ],
    );
    // return ListView.builder(
    //     itemCount: widget.selectedList.length,
    //     itemBuilder: (_, int index) {
    //       return ListTile(
    //           onTap: () => _toggle(index),
    //           onLongPress: () {
    //             if (!widget.isSelectionMode) {
    //               setState(() {
    //                 widget.selectedList[index] = true;
    //               });
    //               widget.onSelectionChange!(true);
    //             }
    //           },
    //           trailing: widget.isSelectionMode
    //               ? Checkbox(
    //             value: widget.selectedList[index],
    //             onChanged: (bool? x) => _toggle(index),
    //           )
    //               : const SizedBox.shrink(),
    //           title: Text('item $index')
    //       );
    //     });
  }
}
