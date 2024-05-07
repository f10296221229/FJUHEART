import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../Icon/MyFlutterApp.dart';
import '../model/Product.dart';
import '../service/PostProvider.dart';

class AIDataGridInner extends StatefulWidget {
  const AIDataGridInner({super.key});

  @override
  State<AIDataGridInner> createState() => _AIDataGridInnerState();
}

class _AIDataGridInnerState extends State<AIDataGridInner> {
  _AIDataGridInnerState();

  String? MEMBER_ID = "";
  String? MEASURE_DT = "";
  String? M00001 = "";
  String? M00002 = "";
  String? M00003 = "";
  String? M00004 = "";
  String? M00005 = "";
  String? M00006 = "";
  String? M00007 = "";
  String pre = "";
  double pre1 = 0.0;

  @override
  void initState() {
    context.read<PostProvider>().AIDataPreDict();
    context.read<PostProvider>().AIData();
    super.initState();
  }

  void main() {
    List<Product> list = context.watch<PostProvider>().AiOutcome;
    pre = context.watch<PostProvider>().preDict.toStringAsFixed(1);
    pre1 = context.watch<PostProvider>().preDict;

    if (list.isEmpty) {
      MEMBER_ID = "目前無資料";
    } else {
      MEMBER_ID = list[0].MEMBER_ID;
      MEASURE_DT = list[0].MEASURE_DT;

      // print(MEASURE_DT);
      M00001 = list[0].M00001.toString();
      M00002 = (list[0].M00002?.toInt()).toString();
      M00003 = (list[0].M00003?.toInt()).toString();
      M00004 = (list[0].M00004?.toInt()).toString();
      M00005 = (list[0].M00005?.toInt()).toString();
      M00006 = (list[0].M00006?.toInt()).toString();
      M00007 = "正常";
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        color: Color(int.parse("dfe6f0", radix: 16)).withAlpha(255),
        child: Builder(builder: (BuildContext context) {
          main();
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Container(
                      //   margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      //   child: const Text(""),
                      // ),
                      // const Icon(
                      //   Icons.square,
                      //   color: Colors.deepOrangeAccent,
                      //   size: 20.0,
                      //   //semanticLabel: 'Text to announce in accessibility modes',
                      // ),
                      const Divider(),
                      Text(
                        MEMBER_ID!,
                        style: const TextStyle(fontSize: 16.0, height: 2),
                      ),
                      const Text(
                        '您好         ',
                        style: TextStyle(
                            fontSize: 12.0,
                            height: 2,
                            color: Color.fromRGBO(80, 79, 79, 1.0)),
                      ),
                      const Divider(),
                      const Text(
                        '最近測量日期:',
                        style: TextStyle(
                            fontSize: 12.0,
                            height: 2,
                            color: Color.fromRGBO(80, 79, 79, 1.0)),
                      ),
                      Text(
                        MEASURE_DT!,
                        style: const TextStyle(fontSize: 16.0, height: 2),
                      )
                    ]),
              ),

              // Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       Container(
              //         margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              //         child: const Text(""),
              //       ),
              //       const Icon(
              //         Icons.square,
              //         color: Colors.deepOrangeAccent,
              //         size: 20.0,
              //         //semanticLabel: 'Text to announce in accessibility modes',
              //       ),
              //       const Divider(),
              //       const Text(
              //         '最近測量日期:',
              //         style: TextStyle(fontSize: 20.0, height: 2),
              //       ),
              //       Text(
              //         MEASURE_DT!,
              //         style: const TextStyle(fontSize: 20.0, height: 2),
              //       )
              //     ]),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  height: 1,
                  color: Color(int.parse("eeeeee", radix: 16)).withAlpha(255),
                ),
              ),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: 75,
                          // margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            border: Border.all(
                                color: Color(int.parse("ffffff", radix: 16))
                                    .withAlpha(255)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(
                              //   MyFlutterApp.thermometer,
                              //   color: Color.fromRGBO(255, 255, 255, 1.0),
                              //   size: 30,
                              // ),
                              Text(
                                '體溫',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(255, 255, 255, 1.0)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                M00001!,
                                style: const TextStyle(
                                  fontSize: 24,
                                  // color: Color.fromRGBO(244, 54, 98, 1.0)
                                ),
                              ),
                              const Text(
                                '  ℃',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(80, 79, 79, 1.0)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: 75,
                          // margin: const EdgeInsets.fromLTRB(50, 0, 5, 0),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            border: Border.all(
                                color: Color(int.parse("ffffff", radix: 16))
                                    .withAlpha(255)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(
                              //   MyFlutterApp.heart_rate,
                              //   color: Color.fromRGBO(244, 54, 98, 1.0),
                              //   size: 40,
                              // ),
                              Text(
                                '心跳',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(255, 255, 255, 1.0)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                M00002!,
                                style: const TextStyle(
                                  fontSize: 24,
                                  // color: Color.fromRGBO(244, 54, 98, 1.0)
                                ),
                              ),
                              const Text(
                                '  分/次',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(80, 79, 79, 1.0)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: 75,
                          // margin: const EdgeInsets.fromLTRB(50, 0, 5, 0),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            border: Border.all(
                                color: Color(int.parse("ffffff", radix: 16))
                                    .withAlpha(255)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(
                              //   MyFlutterApp.breathing,
                              //   color: Color.fromRGBO(244, 54, 98, 1.0),
                              //   size: 40,
                              // ),
                              Text(
                                '呼吸',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(255, 255, 255, 1.0)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                M00003!,
                                style: const TextStyle(
                                  fontSize: 24,
                                  // color: Color.fromRGBO(244, 54, 98, 1.0)
                                ),
                              ),
                              const Text(
                                '  分/次',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(80, 79, 79, 1.0)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: 75,
                          // margin: const EdgeInsets.fromLTRB(50, 0, 5, 0),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            border: Border.all(
                                color: Color(int.parse("ffffff", radix: 16))
                                    .withAlpha(255)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(
                              //   MyFlutterApp.hypertension,
                              //   color: Color.fromRGBO(244, 54, 98, 1.0),
                              //   size: 40,
                              // ),
                              Text(
                                '收縮壓',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(255, 255, 255, 1.0)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                M00004!,
                                style: const TextStyle(
                                  fontSize: 24,
                                  // color: Color.fromRGBO(244, 54, 98, 1.0)
                                ),
                              ),
                              const Text(
                                '  mmHg',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(80, 79, 79, 1.0)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: 75,
                          // margin: const EdgeInsets.fromLTRB(50, 0, 5, 0),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            border: Border.all(
                                color: Color(int.parse("ffffff", radix: 16))
                                    .withAlpha(255)),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(
                              //   MyFlutterApp.hypertension,
                              //   color: Color.fromRGBO(244, 54, 98, 1.0),
                              //   size: 40,
                              // ),
                              Text(
                                '舒張壓',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(255, 255, 255, 1.0)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                M00005!,
                                style: const TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              const Text(
                                '  mmHg',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(80, 79, 79, 1.0)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: 75,
                          // margin: const EdgeInsets.fromLTRB(50, 0, 5, 0),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            border: Border.all(
                                color: Color(int.parse("ffffff", radix: 16))
                                    .withAlpha(255)),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(
                              //   MyFlutterApp.oxygen_saturation,
                              //   color: Color.fromRGBO(244, 54, 98, 1.0),
                              //   size: 40,
                              // ),
                              Text(
                                '血氧',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(255, 255, 255, 1.0)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                M00006!,
                                style: const TextStyle(
                                  fontSize: 24,
                                  // color: Color.fromRGBO(244, 54, 98, 1.0)
                                ),
                              ),
                              const Text(
                                '  %',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(80, 79, 79, 1.0)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: 75,
                          // margin: const EdgeInsets.fromLTRB(50, 0, 5, 0),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            border: Border.all(
                                color: Color(int.parse("ffffff", radix: 16))
                                    .withAlpha(255)),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(
                              //   MyFlutterApp.hypertension,
                              //   color: Color.fromRGBO(244, 54, 98, 1.0),
                              //   size: 40,
                              // ),
                              Text(
                                '心電圖',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(255, 255, 255, 1.0)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                M00007!,
                                style: const TextStyle(
                                  fontSize: 24,
                                  // color: Color.fromRGBO(244, 54, 98, 1.0)
                                ),
                              ),
                              // const Text(
                              //   'mmHg',
                              //   style: TextStyle(
                              //       fontSize: 12,
                              //       color: Color.fromRGBO(80, 79, 79, 1.0)),
                              // ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: const Text(""),
                        ),
                      ],
                    ),
                  ]),
              Divider(
                height: 1,
                color: Color(int.parse("eeeeee", radix: 16)).withAlpha(255),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 400,
                  child: SfRadialGauge(
                      enableLoadingAnimation: true,
                      title: const GaugeTitle(
                        text: 'AI預估風險值',
                        textStyle: TextStyle(
                          fontSize: 24,
                          // color: Color.fromRGBO(244, 54, 98, 1.0)
                        ),
                      ),
                      axes: <RadialAxis>[
                        RadialAxis(
                            minimum: 0,
                            maximum: 100,
                            ranges: <GaugeRange>[
                              GaugeRange(
                                  startValue: 0,
                                  endValue: 35,
                                  color: Colors.green),
                              GaugeRange(
                                  startValue: 35,
                                  endValue: 70,
                                  color: Colors.orange),
                              GaugeRange(
                                  startValue: 70,
                                  endValue: 100,
                                  color: Colors.red)
                            ],
                            pointers: <GaugePointer>[
                              NeedlePointer(
                                  value: pre1,
                                  lengthUnit: GaugeSizeUnit.factor,
                                  needleLength: 0.8,
                                  needleEndWidth: 11,
                                  tailStyle: const TailStyle(
                                    length: 0.2,
                                    width: 11,
                                    gradient: LinearGradient(colors: <Color>[
                                      Color(0xFFFF6B78),
                                      Color(0xFFFF6B78),
                                      Color(0xFFE20A22),
                                      Color(0xFFE20A22)
                                    ], stops: <double>[
                                      0,
                                      0.5,
                                      0.5,
                                      1
                                    ]),
                                  ),
                                  gradient: const LinearGradient(
                                      colors: <Color>[
                                        Color(0xFFFF6B78),
                                        Color(0xFFFF6B78),
                                        Color(0xFFE20A22),
                                        Color(0xFFE20A22)
                                      ],
                                      stops: <double>[
                                        0,
                                        0.5,
                                        0.5,
                                        1
                                      ]),
                                  needleColor: const Color(0xFFF67280),
                                  knobStyle: const KnobStyle(
                                      knobRadius: 0.08,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      color: Colors.black))
                            ],
                            annotations: <GaugeAnnotation>[
                              const GaugeAnnotation(
                                  widget: Text('百分比%',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  angle: 90,
                                  positionFactor: 0.5),
                              GaugeAnnotation(
                                  widget: Text(pre,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  angle: 90,
                                  positionFactor: 0.8)
                            ])
                      ])),
              const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[])
            ],
          );
        }));
  }
}
