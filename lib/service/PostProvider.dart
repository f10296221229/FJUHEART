import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../model/ChartData.dart';
import '../model/Product.dart';
import '../model/login_model.dart';
import 'login_database_helper.dart';
import 'package:http/http.dart' as http;

class PostProvider extends ChangeNotifier {


  double _preDict=0.0;

  List<ChartData> _charts = [];

  List<Product> _tables = [];

  List<Product> _AiOutcome = [];

  List<ChartData> get posts => _charts;

  List<Product> get tables => _tables;

  List<Product> get AiOutcome => _AiOutcome;

  double get preDict => _preDict;

  String now =
      "${DateTime.now().year}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}-${DateTime.now().day < 10 ? "0${DateTime.now().day}" : DateTime.now().day} 23:59:59";
  String t =
      "${DateTime.now().year}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}-01";

  fetchData(String Ms,String Me,String type) async {

    _charts.clear();

    _tables.clear();


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




    var list = json.decode(response.body).cast<Map<String, dynamic>>();
    // print("list");
    // print(list);

    _tables = await list.map<Product>((json) => Product.fromJson(json)).toList();
    // _tables.reversed.toList();

    List<Map<String, dynamic>> list1 = await list;
    for (int i = 0; i < list1.length; i++) {
      ChartData chart = ChartData();
      chart.x = list1[i]["MEASURE_DT"].toString().substring(5, 16);
      chart.y = list1[i]["MEASURE_VALUE"];
      _charts.add(chart);
    }

    notifyListeners();
  }

  fetchData1(String Ms,String Me,String type) async {

    _charts.clear();

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

    _tables = await list.map<Product>((json) => Product.fromJson(json)).toList();
    // _tables.reversed.toList();

    List<Map<String, dynamic>> list1 = await list;
    for (int i = 0; i < list1.length; i++) {
      ChartData chart = ChartData();
      chart.x = list1[i]["MEASURE_DT"].toString().substring(5, 16);
      chart.y = list1[i]["M00004"];
      chart.y1 = list1[i]["M00005"];
      _charts.add(chart);
    }

    // _charts.reversed.toList();
    notifyListeners();
  }


  AIData() async {
    _AiOutcome.clear();

    List<Login>? result = await DatabaseHelper.getAllNotes();
    String? s = result?[0].account;

    var response = await http.post(
      Uri.parse('http://211.20.21.35:8080/fjuheart/MH200110/query'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(<String?, String?>{
        "field1": s
      }),
    );

    var list = json.decode(response.body).cast<Map<String, dynamic>>();
    _AiOutcome = await list.map<Product>((json) => Product.fromJson(json)).toList();

    // print("_AiOutcome.length");
    // print(_AiOutcome.length);
    notifyListeners();
  }

  AIDataPreDict() async {
    // _AiOutcome.clear();

    List<Login>? result = await DatabaseHelper.getAllNotes();
    String? s = result?[0].account;

    var response = await http.post(
      Uri.parse('http://211.20.21.35:8080/fjuheart/MH200110/querypredicttime'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(<String?, String?>{
        "field1": s
      }),
    );

    // print("json.decode(response.body)");
    // print(json.decode(response.body));
    // print(json.decode(response.body)["prediction_result"]);
    var list = json.decode(response.body)["prediction_result"];

    _preDict=await list[0]*100;

    // _AiOutcome = await list.map<Product>((json) => Product.fromJson(json)).toList();

    // print("_AiOutcome.length");
    // print(_AiOutcome.length);
    notifyListeners();
  }

  void removeAll() {
    _charts.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}