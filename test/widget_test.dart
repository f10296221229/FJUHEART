// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:devtest01/model/login_model.dart';
import 'package:devtest01/service/login_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:devtest01/main.dart';
import 'dart:convert';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {


  var DATA = [];
  DATA.add({
    "MEMBER_ID": "doctor"
    , "TRANSACTION_SEQ": "202401171643047050009"
    , "MEASURE_CODE": "M00001"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": 35.5
    , "UPDATE_BY": "doctor"
  });

  DATA.add({
    "MEMBER_ID": "doctor"
    , "TRANSACTION_SEQ": "202401171643047050009"
    , "MEASURE_CODE": "M00002"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": 58
    , "UPDATE_BY": "doctor"
  });

  DATA.add({
    "MEMBER_ID": "doctor"
    , "TRANSACTION_SEQ": "202401171643047050009"
    , "MEASURE_CODE": "M00003"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": 21
    , "UPDATE_BY": "doctor"
  });

  DATA.add({
    "MEMBER_ID": "doctor"
    , "TRANSACTION_SEQ": "202401171643047050009"
    , "MEASURE_CODE": "M00004"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": 120
    , "UPDATE_BY": "doctor"
  });

  DATA.add({
    "MEMBER_ID": "doctor"
    , "TRANSACTION_SEQ": "202401171643047050009"
    , "MEASURE_CODE": "M00005"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": 90
    , "UPDATE_BY": "doctor"
  });

  DATA.add({
    "MEMBER_ID": "doctor"
    , "TRANSACTION_SEQ": "202401171643047050009"
    , "MEASURE_CODE": "M00006"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": 95
    , "UPDATE_BY": "doctor"
  });

  DATA.add({
    "MEMBER_ID": "doctor"
    , "TRANSACTION_SEQ": "202401171643047050009"
    , "MEASURE_CODE": "M00007"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": 0
    , "UPDATE_BY": "doctor"
  });

  DATA.add({
    "MEMBER_ID": "doctor"
    , "TRANSACTION_SEQ": "202401171643047050009"
    , "MEASURE_CODE": "M00008"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": 0
    , "UPDATE_BY": "doctor"
  });

  DATA.add({
    "MEMBER_ID": "doctor"
    , "TRANSACTION_SEQ": "202401171643047050009"
    , "MEASURE_CODE": "M00009"
    , "MEASURE_CODE_GRADE": "0"
    , "MEASURE_VALUE": 0
    , "UPDATE_BY": "doctor"
  });

  var data = {"DATA": DATA};



  final String jsonString = jsonEncode(data);


  print(jsonString);


  // print(int.tryParse("35")==null);

  // DateTime pre=DateTime.now().subtract(Duration(days: 90));
  // String t="${pre.year}-${pre.month < 10 ? "0${pre.month}" : pre.month}-${pre.day < 10 ? "0${pre.day}" : pre.day} 00:00:00";
  // print(t);


  // test('Counter value should be incremented', () async {
  //
  //   // sqfliteFfiInit();
  //   // databaseFactory = databaseFactoryFfi;
  //   // print("object");
  //   //
  //   // List<Login>? result = await DatabaseHelper.getAllNotes();
  //   //
  //   // if(result==null){
  //   //   print("YES");
  //   // }
  //   print('Query Result: $result');

    // final response = await http.post(
    //   Uri.parse('http://211.20.21.35:8080/fjuheart/doMobilelogin'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, Object>{
    //     "Account":"doctor","Password":"12345abcde","verifyCode":"","Loginmode":""
    //   }),
    // );
    //
    // if (response.statusCode == 200) {
    //   // If the server did return a 201 CREATED response,
    //   // then parse the JSON.
    //   // return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    //   print(response.body);
    //   print(jsonDecode(response.body)["status"]);
    //   // print(List<Map<String, dynamic>>.from(jsonDecode(response.body))[0]["CRUD"]);
    //   // print(Map<String, dynamic>.from(jsonDecode(response.body))["id"]);
    //   return  jsonDecode(response.body);
    // } else {
    //   // If the server did not return a 201 CREATED response,
    //   // then throw an exception.
    //   throw Exception('Failed to create album.');
    // }

    // final counter = Counter();
    // counter.increment();

    // expect(counter.value, 1);

}
