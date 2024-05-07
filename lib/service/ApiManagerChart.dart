import 'dart:convert';

import '../model/ChartData.dart';
import '../model/login_model.dart';
import 'login_database_helper.dart';
import 'package:http/http.dart' as http;

class ApiManagerChart {

  ApiManagerChart({required this.Ms,required this.Me,required this.type});

  final String Ms;
  final String Me;
  final String type;



  String now =
      "${DateTime.now().year}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}-${DateTime.now().day < 10 ? "0${DateTime.now().day}" : DateTime.now().day} 23:59:59";
  String t =
      "${DateTime.now().year}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}-01";

  // "${DateTime.now().subtract(const Duration(days: 20)).year}-${DateTime.now().subtract(const Duration(days: 20)).month < 10 ? "0${DateTime.now().subtract(const Duration(days: 20)).month}" : DateTime.now().subtract(const Duration(days: 20)).month}-${DateTime.now().subtract(const Duration(days: 20)).day < 10 ? "0${DateTime.now().subtract(const Duration(days: 20)).day}" : DateTime.now().subtract(const Duration(days: 20)).day} 00:00:00";

  Future<List<ChartData>> generateProductList() async {
    List<ChartData> charts = [];

    List<Login>? result = await DatabaseHelper.getAllNotes();
    String? s = result?[0].account;

    var response = await http.post(
      Uri.parse('http://211.20.21.35:8080/fjuheart/MH200102/query'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(<String?, String?>{
        "field1": s,
        "field2": Ms == "" ? t : "$Ms 00:00:00",
        "field3": Me == "" ? now : "$Me 23:59:59",
        "field4": type
      }),
    );

    if (response.statusCode != 200) {

      print("連線失敗連線失敗連線失敗連線失敗連線失敗連線失敗連線失敗連線失敗連線失敗連線失敗");
    }



    var list = json.decode(response.body).cast<Map<String, dynamic>>();
    // print("list");
    // print(list);


    List<Map<String, dynamic>> list1 = await list;
    for (int i = 0; i < list1.length; i++) {
      ChartData chart = ChartData();
      chart.x = list1[i]["MEASURE_DT"].toString().substring(5, 16);
      chart.y = list1[i]["MEASURE_VALUE"];
      charts.add(chart);
    }
    return charts;
  }


  Future<List<ChartData>> generateProductList1() async {
    List<ChartData> charts = [];
    // List<ChartData> charts1 = [];
    // List<List<ChartData>> chartsmix=[];

    List<Login>? result = await DatabaseHelper.getAllNotes();
    String? s = result?[0].account;

    var response = await http.post(
      Uri.parse('http://211.20.21.35:8080/fjuheart/MH200101/query'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(<String?, String?>{
        "field1": s,
        "field2": Ms == "" ? t : "$Ms 00:00:00",
        "field3": Me == "" ? now : "$Me 23:59:59",
        "field4": type
      }),
    );
    //
    var list = json.decode(response.body).cast<Map<String, dynamic>>();
    // var chart=await list;

    List<Map<String, dynamic>> list1 = await list;
    for (int i = 0; i < list1.length; i++) {
      ChartData chart = ChartData();
      chart.x = list1[i]["MEASURE_DT"].toString().substring(5, 16);
      chart.y = list1[i]["M00004"];
      chart.y1 = list1[i]["M00005"];
      charts.add(chart);
    }

    // for (int i = 0; i < list1.length; i++) {
    //   ChartData chart = ChartData();
    //   chart.x = list1[i]["MEASURE_DT"].toString().substring(5, 16);
    //   chart.y = list1[i]["M00005"];
    //   charts1.add(chart);
    // }

    // chartsmix.add(charts);
    // chartsmix.add(charts1);

    return charts.reversed.toList();
  }
}