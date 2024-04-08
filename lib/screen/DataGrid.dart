import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DataGrid extends StatefulWidget {
  /// Creates the home page.
  const DataGrid({Key? key}) : super(key: key);

  @override
  _DataGrid createState() => _DataGrid();
}

class _DataGrid extends State<DataGrid> {
  List<Map<String, Object>> employees = <Map<String, Object>>[];
  late EmployeeDataSource employeeDataSource;

  final DataGridController _dataGridController = DataGridController();

  @override
  void initState() {
    super.initState();
    // employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: SfDataGrid(
        source: employeeDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'MEASURE_DT',
              label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const Text(
                    '測量日期',
                  ))),
          GridColumn(
              columnName: 'M00001',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('體溫'))),
          GridColumn(
              columnName: 'M00002',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    '心跳',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'M00003',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('呼吸'))),
        ],
        selectionMode: SelectionMode.single,
        controller: _dataGridController,
        onCellTap: (DataGridCellTapDetails details) {
          //SelectedIndex
          // var _selectedIndex = _dataGridController.selectedIndex;

          //SelectedRow
          // var _selectedRow = _dataGridController.selectedRow;

          //SelectedRows
          // var _selectedRows = _dataGridController.selectedRows;

          // print(_selectedIndex);
          // print(_dataGridController.currentCell);
          print(employeeDataSource.effectiveRows[details.rowColumnIndex.rowIndex - 1].getCells()[0].value.toString());
          print(employeeDataSource.effectiveRows[details.rowColumnIndex.rowIndex - 1].getCells()[1].value.toString());
          print(employeeDataSource.effectiveRows[details.rowColumnIndex.rowIndex - 1].getCells()[2].value.toString());
          print(employeeDataSource.effectiveRows[details.rowColumnIndex.rowIndex - 1].getCells()[3].value.toString());



          // print(_selectedRows);
          // print(
          //     Text(employeeDataSource
          //     .effectiveRows[details.rowColumnIndex.rowIndex - 1]
          //     .getCells()[details.rowColumnIndex.columnIndex]
          //     .value
          //     .toString())
          // );
        },
      ),
    );
  }

  // resp(String account, String password) async {
  //   String flag = "";
  //   final response = await http.post(
  //     Uri.parse('http://211.20.21.35:8080/MH200101/query'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       // 'Access-Control-Allow-Origin': '*',
  //     },
  //     body: jsonEncode(<String, String>{
  //       "field1": "doctor",
  //       "field2": "2023-10-01 00:00:00",
  //       "field3": "2024-10-01 23:59:59"
  //     }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //     //   if (jsonDecode(response.body)["status"] == "Success") {
  //     //     flag = "Y";
  //     //   } else {
  //     //     flag = "帳號密碼錯誤";
  //     //   }
  //     // } else {
  //     //   flag = "連線失敗";
  //   }
  //
  //   return flag;
  // }


  // Future<List<Map<String, Object>>?> getEmployeeData()  async {
  //   final response = await http.post(
  //     Uri.parse('http://211.20.21.35:8080/MH200101/query'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       // 'Access-Control-Allow-Origin': '*',
  //     },
  //     body: jsonEncode(<String, String>{
  //       "field1": "doctor",
  //       "field2": "2023-10-01 00:00:00",
  //       "field3": "2024-10-01 23:59:59"
  //     }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   }else{
  //     return null;
  //   }
  // }

  // Future<void> generateProductList() async {
  //   var response = await http.post(
  //       Uri.parse('http://211.20.21.35:8080/MH200101/query')
  //       ,headers: <String, String>{
  //             'Content-Type': 'application/json; charset=UTF-8',
  //             // 'Access-Control-Allow-Origin': '*',
  //           },
  //           body: jsonEncode(<String, String>{
  //             "field1": "doctor",
  //             "field2": "2023-10-01 00:00:00",
  //             "field3": "2024-10-01 23:59:59"
  //           }),
  //   );
  //   var list = json.decode(response.body).cast<Map<String, dynamic>>();
  //   var productlist =
  //   await list.map<Employee>((json) => Employee.fromJson(json)).toList();
  //   employeeDataSource = EmployeeDataSource(employeeData: productlist);
  //   return productlist;
  // }



}



class Employee {
//   /// Creates the employee class with required details.
//   Employee(this.id, this.name, this.designation, this.salary);
//
//   /// Id of an employee.
//   late final int id;
//
//   /// Name of an employee.
  late final String MEASURE_DT;
//
//   /// Designation of an employee.
  late final String M00001;
  late final String M00002;
  late final String M00003;
//
//   /// Salary of an employee.
//   late final int salary;
}

class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Map<String, Object>> employeeData}) {
    // _employeeData=employeeData.
    _employeeData = employeeData.map<DataGridRow>((e) =>
        DataGridRow(cells: [
          DataGridCell<Object>(
              columnName: 'MEASURE_DT', value: e["MEASURE_DT"]),
          DataGridCell<double>(columnName: 'M00001',
              value: double.parse(e["M00001"].toString())),
          DataGridCell<int>(columnName: 'M00002',
              value: double.parse(e["M00002"].toString()).toInt()),
          DataGridCell<int>(columnName: 'M00003',
              value: double.parse(e["M00003"].toString()).toInt()),
        ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}
