import 'dart:convert';
import '../model/Product.dart';
import '../model/login_model.dart';
import 'login_database_helper.dart';
import 'package:http/http.dart' as http;

class ApiManagerTable {

  ApiManagerTable({required this.Ms,required this.Me,required this.type});

  final String Ms;
  final String Me;
  final String type;

  List<Product> productlist = [];

  String now =
      "${DateTime.now().year}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}-${DateTime.now().day < 10 ? "0${DateTime.now().day}" : DateTime.now().day} 23:59:59";
  String t =
      "${DateTime.now().year}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}-01";

  // "${DateTime.now().subtract(const Duration(days: 180)).year}-${DateTime.now().subtract(const Duration(days: 180)).month < 10 ? "0${DateTime.now().subtract(const Duration(days: 180)).month}" : DateTime.now().subtract(const Duration(days: 180)).month}-${DateTime.now().subtract(const Duration(days: 180)).day < 10 ? "0${DateTime.now().subtract(const Duration(days: 180)).day}" : DateTime.now().subtract(const Duration(days: 180)).day} 00:00:00";

  Future generateProductList() async {
    List<Login>? result = await DatabaseHelper.getAllNotes();
    String? s = result?[0].account;

    String str="";
    if(type=="M00004"){
      str="http://211.20.21.35:8080/fjuheart/MH200101/query";
    }else{
      str="http://211.20.21.35:8080/fjuheart/MH200102/query";
    }

    var response = await http.post(
      Uri.parse(str),
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
    productlist = await list.map<Product>((json) => Product.fromJson(json)).toList();
    return productlist;
  }
}
