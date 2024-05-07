import 'dart:convert';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../model/Product.dart';
import '../model/login_model.dart';
import '../partition/ListBuilder.dart';
import '../service/login_database_helper.dart';
import 'HomeScreen1.dart';
import 'InsertDataScreen.dart';
import 'UpdateDataScreen.dart';
import '../model/Product1.dart';

late _JsonDataGridSource jsonDataGridSource;
late _JsonDataGridSource1 jsonDataGridSource1;

late Future<dynamic> userDataFuture1;

late String MEASURE_DT_S = "";
late String MEASURE_DT_E = "";
late String TRANSACTION_SEQ1 = "";
late String MEASURE_DT1 = "";

class JsonDataGrid extends StatefulWidget {
  JsonDataGrid({required this.Measure_s, required this.Measure_e});

  final String Measure_s;
  final String Measure_e;

  @override
  createState() =>
      _JsonDataGridState(Measure_s: Measure_s, Measure_e: Measure_e);
}

class _JsonDataGridState extends State<JsonDataGrid> {
  late String Measure_s;
  late String Measure_e;

  _JsonDataGridState({required this.Measure_s, required this.Measure_e});

  bool _isGridMode = true;
  bool _selectMode = true;

  @override
  void initState() {
    String d =
        "${DateTime.now().year}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}-${DateTime.now().day < 10 ? "0${DateTime.now().day}" : DateTime.now().day}";
    String t =
        "${DateTime.now().year}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}-01";

    // "${DateTime.now().subtract(const Duration(days: 180)).year}-${DateTime.now().subtract(const Duration(days: 180)).month < 10 ? "0${DateTime.now().subtract(const Duration(days: 180)).month}" : DateTime.now().subtract(const Duration(days: 180)).month}-${DateTime.now().subtract(const Duration(days: 180)).day < 10 ? "0${DateTime.now().subtract(const Duration(days: 180)).day}" : DateTime.now().subtract(const Duration(days: 180)).day}";

    MEASURE_DT_S = Measure_s == "" ? t : Measure_s;
    MEASURE_DT_E = Measure_e == "" ? d : Measure_e;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan,
        leading:
        Row(
          children: [
            // IconButton(
            //     icon: const Icon(
            //         Icons.arrow_back
            //         ,color: Color.fromRGBO(255, 255, 255, 1)
            //     ),
            //     onPressed: () {
            //       Navigator.pushReplacement(context,
            //           MaterialPageRoute(builder: (BuildContext context) {
            //             return const HomeScreen1();
            //           }));
            //     }),
            _selectMode ? IconButton(
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
                })
          ],
        )
        // IconButton(
        //     icon: const Icon(Icons.arrow_back),
        //     onPressed: () {
        //       Navigator.pushReplacement(context,
        //           MaterialPageRoute(builder: (BuildContext context) {
        //             return   const HomeScreen1();
        //           }));
        //     }
        // ),
        ,title: const Text('生理指標',style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1))),
      ),
      body: _isGridMode ?
      Container(
        color: Color(int.parse("dfe6f0", radix: 16)).withAlpha(255),
        child: ListView(
            children: <Widget>[
              Card(
                margin: const EdgeInsets.all(10),
                color: Colors.green[100],
                shadowColor: Colors.blueGrey,
                elevation: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Ink(
                      color: Colors.purple[600],
                      height: 20,
                      child: ListTile(
                        title: const Text(''),
                        onTap: () {},
                      ),
                    ),

                    const TextSectionDate(),
                  ],
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // 垂直靠下
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      // height: 50,
                      // width: 300,
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: TextButton(
                          //一个凸起的材质矩形按钮
                            style: TextButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                  // side: BorderSide(color: Colors.red)
                                ),
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.black,
                                minimumSize:
                                Size(MediaQuery.of(context).size.width - 20, 40)
                              // elevation: 10,
                            ),
                            child: const Text(
                              '新增紀錄',
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1.0),
                                  fontSize: 20),
                            ),
                            onPressed: () async {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (BuildContext context) {
                                    return  InsertDataScreen(MEASURE_DT_S1: MEASURE_DT_S, MEASURE_DT_E1: MEASURE_DT_E,);
                                  }));
                            })),
                  ]),
              const Row(children: <Widget>[
                Icon(
                  Icons.favorite,
                  color: Colors.pink,
                  size: 28.0,
                  //semanticLabel: 'Text to announce in accessibility modes',
                ),
                Divider(),
                Text(
                  '近期數據',
                  style: TextStyle(fontSize: 28.0, height: 2),
                )
              ]),
              const Builder(),
              PopScope(
                canPop: false,
                onPopInvoked : (didPop){
                  if (didPop) {
                    return;
                  }
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return   const HomeScreen1();
                      }));
                  // logic
                }, child: const Text(''),
              )
            ]),
      )
       : const ListBuilder(),
    );
  }
}

class Builder extends StatefulWidget {
  const Builder({super.key});

  @override
  BuilderState createState() => BuilderState();
}

class BuilderState extends State<Builder> {
  late Future<dynamic> userDataFuture;
  @override
  void initState() {
    userDataFuture = ApiManager().generateProductList();
    super.initState();
  }

  void refreshList() {
    setState(() {
      userDataFuture = ApiManager().generateProductList();
    });
  }

  List<GridColumn> getColumns() {
    List<GridColumn> columns;
    columns = ([
      GridColumn(
        columnName: 'MEASURE_DT',
        width: 150,
        label: Container(
          padding: const EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          child: const Text(
            '測量日期',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'TRANSACTION_SEQ',
        visible: false,
        // width: 150,
        label: Container(
          padding: const EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          child: const Text(
            'TRANSACTION_SEQ',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      // GridColumn(
      //     columnName: 'MEASURE_DT',
      //     label: Container(
      //         padding: const EdgeInsets.all(16.0),
      //         alignment: Alignment.center,
      //         child: const Text(
      //           '測量日期',
      //         ))),
      GridColumn(
          columnName: 'M00001',
          label: Container(
              // width: 200,
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              child: const Text('體溫'))),
      GridColumn(
          columnName: 'M00002',
          label: Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              child: const Text(
                '心跳',
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'M00003',
          label: Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              child: const Text('呼吸'))),
      // GridColumn(
      //   columnName: 'MEASURE_DT',
      //   width: 70,
      //   label: Container(
      //     padding: EdgeInsets.all(8),
      //     alignment: Alignment.centerLeft,
      //     child: Text(
      //       'MEASURE_DT',
      //       overflow: TextOverflow.clip,
      //       softWrap: true,
      //     ),
      //   ),
      // ),
      // GridColumn(
      //   columnName: 'customerID',
      //   width: 95,
      //   label: Container(
      //     padding: EdgeInsets.all(8),
      //     alignment: Alignment.centerRight,
      //     child: Text(
      //       'Customer ID',
      //       overflow: TextOverflow.clip,
      //       softWrap: true,
      //     ),
      //   ),
      // ),
      // GridColumn(
      //   columnName: 'employeeID',
      //   width: 95,
      //   label: Container(
      //     padding: EdgeInsets.all(8),
      //     alignment: Alignment.centerLeft,
      //     child: Text(
      //       'Employee ID',
      //       overflow: TextOverflow.clip,
      //       softWrap: true,
      //     ),
      //   ),
      // ),
      // GridColumn(
      //   columnName: 'orderDate',
      //   width: 100,
      //   label: Container(
      //     padding: EdgeInsets.all(8),
      //     alignment: Alignment.centerRight,
      //     child: Text(
      //       'Order Date',
      //       overflow: TextOverflow.clip,
      //       softWrap: true,
      //     ),
      //   ),
      // ),
      // GridColumn(
      //   columnName: 'freight',
      //   width: 70,
      //   label: Container(
      //     padding: EdgeInsets.all(8),
      //     alignment: Alignment.centerLeft,
      //     child: Text('Freight'),
      //   ),
      // )
    ]);
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return
      FittedBox(
        // height: MediaQuery.of(context).size.height ,
        child: FutureBuilder(
            future: userDataFuture,
            // key: key,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return SfDataGrid(
                      highlightRowOnHover: true,
                      headerRowHeight: 30,
                      rowHeight: 40,
                      // allowPullToRefresh: true,
                      // shrinkWrapRows: true,
                      showVerticalScrollbar: true,
                      // showHorizontalScrollbar: true,
                      columnWidthMode: ColumnWidthMode.fill,
                      source: jsonDataGridSource,
                      columns: getColumns(),
                      selectionMode: SelectionMode.single,

                      // columnWidthMode: ColumnWidthMode.fill,
                      // shrinkWrapRows: true,
                      // rowHeight: 40,
                      // headerRowHeight: 40,
                      // source: jsonDataGridSource1,
                      // columns: getColumns(),
                      // selectionMode: SelectionMode.single,
                      // onCellTap: (DataGridCellTapDetails details) {});


                      onCellTap: (DataGridCellTapDetails details) {
                        TRANSACTION_SEQ1 = jsonDataGridSource
                            .effectiveRows[details.rowColumnIndex.rowIndex - 1]
                            .getCells()[1]
                            .value
                            .toString();
                        MEASURE_DT1 = jsonDataGridSource
                            .effectiveRows[details.rowColumnIndex.rowIndex - 1]
                            .getCells()[0]
                            .value
                            .toString();
                        //print(jsonDataGridSource.effectiveRows[details.rowColumnIndex.rowIndex - 1].getCells()[1].value.toString());
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const JsonDataGridView1();
                            }));
                      });
                  //Show data here
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  );

                  //Show error here
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                );
                //Show progress
              }
            }),
      );

  }
}

class ApiManager {
  List<Product> productlist = [];

  String now =
      "${DateTime.now().year}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}-${DateTime.now().day < 10 ? "0${DateTime.now().day}" : DateTime.now().day} 23:59:59";
  String t =
      "${DateTime.now().year}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}-01";

  // "${DateTime.now().subtract(const Duration(days: 180)).year}-${DateTime.now().subtract(const Duration(days: 180)).month < 10 ? "0${DateTime.now().subtract(const Duration(days: 180)).month}" : DateTime.now().subtract(const Duration(days: 180)).month}-${DateTime.now().subtract(const Duration(days: 180)).day < 10 ? "0${DateTime.now().subtract(const Duration(days: 180)).day}" : DateTime.now().subtract(const Duration(days: 180)).day} 00:00:00";

  Future generateProductList() async {
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
        "field2": MEASURE_DT_S == "" ? t : "$MEASURE_DT_S 00:00:00",
        "field3": MEASURE_DT_E == "" ? now : "$MEASURE_DT_E 23:59:59"
      }),
    );

    var list = json.decode(response.body).cast<Map<String, dynamic>>();
    productlist =
        await list.map<Product>((json) => Product.fromJson(json)).toList();
    jsonDataGridSource = _JsonDataGridSource(productlist);
    return productlist;
  }
}

class _JsonDataGridSource extends DataGridSource {
  _JsonDataGridSource(this.productlist) {
    buildDataGridRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<Product> productlist = [];

  void buildDataGridRow() {
    dataGridRows = productlist.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'MEASURE_DT', value: dataGridRow.MEASURE_DT),
        DataGridCell<String>(
            columnName: 'TRANSACTION_SEQ', value: dataGridRow.TRANSACTION_SEQ),
        DataGridCell<double>(columnName: 'M00001', value: dataGridRow.M00001),
        DataGridCell<int>(
            columnName: 'M00002',
            value: double.parse(dataGridRow.M00002.toString()).toInt()),
        DataGridCell<int>(
            columnName: 'M00003',
            value: double.parse(dataGridRow.M00003.toString()).toInt()),
        // DataGridCell<double>(columnName: 'freight', value: dataGridRow.freight),
      ]);
    }).toList(growable: false);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  void updateDataGridSource() {
    notifyListeners();
  }

}

class TextSectionDate extends StatefulWidget {
  const TextSectionDate({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TextSectionDate();
  }
}
class _TextSectionDate extends State<TextSectionDate> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _date = TextEditingController();
  TextEditingController _date_e = TextEditingController();
  final format = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();
    _date = TextEditingController(text: MEASURE_DT_S);
    _date_e = TextEditingController(text: MEASURE_DT_E);
  }



  //姓名
  Widget buildNameTextField(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      // data: ThemeData(primaryColor: Colors.amber, hintColor: Colors.black),
      child: DateTimeField(
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100),
              // builder: (context, child) => Localizations.override(
              //   context: context,
              //   locale: const Locale('zh'),
              //   child: child,
              // ),
            );
          },
          //键盘的样式
          keyboardType: TextInputType.datetime,
          //监听
          controller: _date,
          //最大长度
          // maxLength: 30,
          //颜色跟hintColor
          //最大行数
          maxLines: 1,
          //是否自动更正
          autocorrect: false,
          //是否自动化对焦
          autofocus: false,
          //是否是密码格式(输入的内容不可见)
          obscureText: false,
          //文本对齐方式
          textAlign: TextAlign.start,
          //输入文本的样式
          style: const TextStyle(fontSize: 16, color: Colors.black),
          //允许输入的格式(digitsOnly数字)
          // inputFormatters: [
          //   FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
          // ],
          //内容改变回调
          onChanged: (account) {
            setState(() {
              MEASURE_DT_S =
                  "${account?.year}-${account!.month < 10 ? "0${account.month}" : account.month}-${account.day < 10 ? "0${account.day}" : account.day}";
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return JsonDataGrid(
                    Measure_s: MEASURE_DT_S, Measure_e: MEASURE_DT_E);
              }));
            });
            // setState(() {

            // userDataFuture=ApiManager("2024-03-25 00:00:00","2024-03-25 23:59:59").generateProductList();

            // print(userDataFuture);

            // jsonDataGridSource.buildDataGridRow();

            // jsonDataGridSource.updateDataGridSource();

            // FocusScope.of(context).requestFocus(FocusNode());
            // _selectDate(context);
            // _dayFocus.unfocus();

            // MEASURE_DT_S = "2024-03-24 00:00:00";
            // MEASURE_DT_E = "2024-03-25 23:59:59";

            // Builder builder = const Builder();
            // builder.createState();

            // print('$MEASURE_DT_S');
            // });
          },
          // onChanged: (account) {
          //   BuilderState builder =  BuilderState();
          //   builder.refreshList();
          // },
          // onTap: ()  {
          //   FocusScope.of(context).requestFocus(FocusNode());
          //   _selectDate(context);
          //   print('change');
          // },
          //提交触发回调
          // onSubmitted: (account) {
          //   // print('submit $account');
          // },
          //是否禁用
          enabled: true,
          decoration: InputDecoration(
              fillColor: Colors.blue[50],
              //底色
              filled: true,
              //有聚焦，labelText就会缩小到输入框左上角，颜色primaryColor，没聚焦前颜色跟hintColor
              // labelText: '帳號',
              //聚焦时才显示,颜色跟hintColor
              // hintText: '請輸入姓名',
              //红色
//            errorText: '输入错误',
              //红色，现在在输入框的左下角，跟errorText位置一样(优先显示errorText)
//            helperText: 'acount',
              //输入框内左侧，有聚焦，颜色跟primaryColor
              // prefixIcon: const Icon(Icons.person),
              //输入框左侧的widget（可是text、icon……）
              icon: const Text(
                '開始：',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              isDense: true,
              contentPadding: const EdgeInsets.all(8),
              //输入框内右侧的widget
              // suffixIcon: const Icon(Icons.account_circle),
//            有聚焦显示颜色跟hintColor，显示在输入框的右边
//             suffixText: "后缀",
//               contentPadding: const EdgeInsets.all(5),
              border: const OutlineInputBorder(
                // borderRadius: BorderRadius.circular(21.11), //边框裁剪成11.11°角
                borderSide: BorderSide(
                    color: Colors.black,
                    width: 25.0), //边框颜色、大小没有效果，所以使用返回的是Theme，
              ))),
    );
  }

  Widget buildNameTextField1(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      // data: ThemeData(primaryColor: Colors.amber, hintColor: Colors.black),
      child: DateTimeField(
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
              context: context,
              firstDate: DateTime(2020),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100),
              // builder: (context, child) => Localizations.override(
              //   context: context,
              //   locale: const Locale('zh'),
              //   child: child,
              // ),
            );
          },
          //键盘的样式
          keyboardType: TextInputType.datetime,
          //监听
          controller: _date_e,
          //最大长度
          // maxLength: 30,
          //颜色跟hintColor
          //最大行数
          maxLines: 1,
          //是否自动更正
          autocorrect: false,
          //是否自动化对焦
          autofocus: false,
          //是否是密码格式(输入的内容不可见)
          obscureText: false,
          //文本对齐方式
          textAlign: TextAlign.start,
          //输入文本的样式
          style: const TextStyle(fontSize: 16, color: Colors.black),
          //允许输入的格式(digitsOnly数字)
          // inputFormatters: [
          //   FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
          // ],
          //内容改变回调

          onChanged: (account) {
            setState(() {
              MEASURE_DT_E =
                  "${account?.year}-${account!.month < 10 ? "0${account.month}" : account.month}-${account.day < 10 ? "0${account.day}" : account.day}";
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return JsonDataGrid(
                    Measure_s: MEASURE_DT_S, Measure_e: MEASURE_DT_E);
              }));
            });
          },

          //是否禁用
          enabled: true,
          decoration: InputDecoration(
              fillColor: Colors.blue[50],
              //底色
              filled: true,
              //有聚焦，labelText就会缩小到输入框左上角，颜色primaryColor，没聚焦前颜色跟hintColor
              // labelText: '帳號',
              //聚焦时才显示,颜色跟hintColor
              // hintText: '請輸入姓名',
              //红色
//            errorText: '输入错误',
              //红色，现在在输入框的左下角，跟errorText位置一样(优先显示errorText)
//            helperText: 'acount',
              //输入框内左侧，有聚焦，颜色跟primaryColor
              // prefixIcon: const Icon(Icons.person),
              //输入框左侧的widget（可是text、icon……）
              icon: const Text(
                '結束：',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              isDense: true,
              contentPadding: const EdgeInsets.all(8),
              //输入框内右侧的widget
              // suffixIcon: const Icon(Icons.account_circle),
//            有聚焦显示颜色跟hintColor，显示在输入框的右边
//             suffixText: "后缀",
//               contentPadding: const EdgeInsets.all(5),
              border: const OutlineInputBorder(
                // borderRadius: BorderRadius.circular(21.11), //边框裁剪成11.11°角
                borderSide: BorderSide(
                    color: Colors.black,
                    width: 25.0), //边框颜色、大小没有效果，所以使用返回的是Theme，
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        //主轴Flex的值
        mainAxisSize: MainAxisSize.max,
        //MainAxisAlignment：主轴方向上的对齐方式，会对child的位置起作用
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildNameTextField(_date),
          buildNameTextField1(_date_e),
        ],
      ),
    );
  }
}

class JsonDataGridView1 extends StatefulWidget {
  const JsonDataGridView1({super.key});
  @override
  createState() => _JsonDataGridView1();
}

class _JsonDataGridView1 extends State<JsonDataGridView1> {
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
  @override
  void initState() {
    userDataFuture1 = ApiManager1().generateProductList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back,color: Color.fromRGBO(255, 255, 255, 1)),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return   JsonDataGrid(Measure_s: MEASURE_DT_S, Measure_e: MEASURE_DT_E,);
                  }));
            }
        ),
        title: const Text('生理指標',style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1))),
      ),
      body:
      Container(
        color: Color(int.parse("dfe6f0", radix: 16)).withAlpha(255),
        child: ListView(children: <Widget>[
          PopScope(
            canPop: false,
            onPopInvoked : (didPop){
              if (didPop) {
                return;
              }
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return  JsonDataGrid(Measure_s: MEASURE_DT_S, Measure_e: MEASURE_DT_E,);
                  }));
              // logic
            }, child: const Divider(height: 0,),
          ),
          const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.square,
                  color: Colors.deepPurpleAccent,
                  size: 32.0,
                  //semanticLabel: 'Text to announce in accessibility modes',
                ),
                Divider(),
                Text(
                  '個人數據',
                  style: TextStyle(fontSize: 32.0, height: 2),
                )
              ]),
          Row(children: <Widget>[
            const Icon(
              Icons.square,
              color: Colors.deepOrangeAccent,
              size: 20.0,
              //semanticLabel: 'Text to announce in accessibility modes',
            ),
            const Divider(),
            Text(
              '測量日期:$MEASURE_DT1',
              style: const TextStyle(fontSize: 20.0, height: 2),
            )
          ]),
          const BuilderView1(),
          const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[UpdateButton()]),
        ]),
      )
      ,
    );
  }
}

class BuilderView1 extends StatefulWidget {
  const BuilderView1({super.key});
  @override
  createState() => BuilderStateView1();
}

class BuilderStateView1 extends State<BuilderView1> {
  List<GridColumn> getColumns() {
    List<GridColumn> columns;
    columns = ([
      GridColumn(
        columnName: 'MEASURE_NAME',
        // width: 150,
        label: Container(
          padding: const EdgeInsets.all(5),
          alignment: Alignment.center,
          child: const Text(
            '測量指標',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'MEASURE_CODE_GRADE',
        // visible: false,
        // width: 150,
        label: Container(
          padding: const EdgeInsets.all(5),
          alignment: Alignment.center,
          child: const Text(
            '測量數據',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
    ]);
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userDataFuture1,
        // key: key,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return SfDataGrid(
                  // showVerticalScrollbar: false,
                  // showHorizontalScrollbar: false,
                  // isScrollbarAlwaysShown: true,
                  // allowPullToRefresh: true,
                  columnWidthMode: ColumnWidthMode.fill,
                  shrinkWrapRows: true,
                  rowHeight: 40,
                  headerRowHeight: 40,
                  source: jsonDataGridSource1,
                  columns: getColumns(),
                  selectionMode: SelectionMode.single,
                  onCellTap: (DataGridCellTapDetails details) {});
              //Show data here
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              );

              //Show error here
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            );
            //Show progress
          }
        });
  }
}

class ApiManager1 {
  Future generateProductList() async {
    List<Product1> productlist = [];
    List<Login>? result = await DatabaseHelper.getAllNotes();
    String? s = result?[0].account;

    var response = await http.post(
      Uri.parse('http://211.20.21.35:8080/fjuheart/MH200101/queryline1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(
          <String?, String?>{"field1": s, "field2": TRANSACTION_SEQ1}),
    );
    var list = json.decode(response.body).cast<Map<String, dynamic>>();

    productlist = await list.map<Product1>((json) => Product1.fromJson(json)).toList();

    List<Product1> productlist1 = [];

    for(Product1 p in productlist){
      if(p.MEASURE_CODE=="M00008" || p.MEASURE_CODE=="M00009"){

      }else{
        productlist1.add(p);
      }
    }

    jsonDataGridSource1 = _JsonDataGridSource1(productlist1);
    return productlist1;
  }

  Future<List<Product1>> generateProductList1() async {
    List<Product1> productlist = [];
    List<Login>? result = await DatabaseHelper.getAllNotes();
    String? s = result?[0].account;

    var response = await http.post(
      Uri.parse('http://211.20.21.35:8080/fjuheart/MH200101/queryline1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(
          <String?, String?>{"field1": s, "field2": TRANSACTION_SEQ1}),
    );
    var list = json.decode(response.body).cast<Map<String, dynamic>>();
    productlist = await list.map<Product1>((json) => Product1.fromJson(json)).toList();
    return productlist;
  }

  Future generateProductList2() async {
    String? P="";
    List<Product1> productlist = [];
    List<Login>? result = await DatabaseHelper.getAllNotes();
    String? s = result?[0].account;

    var response = await http.post(
      Uri.parse('http://211.20.21.35:8080/fjuheart/MH200101/queryline2'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(
          <String?, String?>{"field1": s, "field2": TRANSACTION_SEQ1}),
    );
    var list = json.decode(response.body).cast<Map<String, dynamic>>();

    productlist = await list.map<Product1>((json) => Product1.fromJson(json)).toList();
    if(productlist.isNotEmpty){
      P=productlist[0].PIC;
    }else{
      P="";
    }
    return P;
  }
}

class _JsonDataGridSource1 extends DataGridSource {
  _JsonDataGridSource1(this.productlist) {
    buildDataGridRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<Product1> productlist = [];

  void buildDataGridRow() {
    dataGridRows = productlist.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<Object>(
            columnName: 'MEASURE_NAME',
            value:
                "${dataGridRow.MEASURE_NAME!}(${dataGridRow.MEASURE_REMARK})"),
        DataGridCell<Object>(
            columnName: 'MEASURE_CODE_GRADE',
            // value: double.parse(dataGridRow.MEASURE_CODE_GRADE==null ? "":dataGridRow.MEASURE_CODE_GRADE.toString())),
            value: dataGridRow.MEASURE_CODE_GRADE == null
                ? ""
                : dataGridRow.MEASURE_CODE_GRADE
                    .toString()
                    .replaceAll(".0", "")),
      ]);
    }).toList(growable: false);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        // padding: const EdgeInsets.all(0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}


class UpdateButton extends StatefulWidget {
  const UpdateButton({super.key});
  @override
  createState() => _UpdateButton();
}

class _UpdateButton extends State<UpdateButton> {
  Future<void> main(BuildContext context) async{
    ApiManager1 apiManager1 = ApiManager1();
    var a=await apiManager1.generateProductList2();

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
          return  UpdateDataScreen(imageUrl: a,);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        // 水平讓各自 Container 間有間距
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // 垂直靠下
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              // color: Colors.red,
              child: ElevatedButton(
                  //一个凸起的材质矩形按钮
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(115, 229, 121, 1.0),
                    foregroundColor: Colors.black,
                    elevation: 0,
                  ),
                  // color: Colors.red,
                  child: const Text(
                    '修改紀錄',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1.0),
                        fontSize: 20),
                  ),
                  onPressed: (){
                    main(context);
                    // ApiManager1 apiManager1 = ApiManager1();
                    // var a=await apiManager1.generateProductList2();
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (BuildContext context) {
                    //   return  UpdateDataScreen(imageUrl: a,);
                    // }));

                    //   // Navigator.pushNamed(context, '/test');
                  }))
        ]);
  }
}
