import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/Product.dart';
import '../service/ApiManagerTable.dart';
late _JsonDataGridSource jsonDataGridSource;
class NewTableWidget extends StatefulWidget {
  const NewTableWidget({super.key, required this.Ms,required this.Me,required this.type,required this.typeName});
  final String Ms;
  final String Me;
  final String type;
  final String typeName;
  @override
  State<NewTableWidget> createState() => _NewTableWidgetState(Ms: Ms, Me: Me, type: type, typeName: typeName);
}

class _NewTableWidgetState extends State<NewTableWidget> {
  _NewTableWidgetState({required this.Ms,required this.Me,required this.type,required this.typeName});
  late Future<dynamic> userDataFuture;

  final String Ms;
  final String Me;
  final String type;
  final String typeName;

  @override
  void initState() {
    main();
    userDataFuture = _getList();
    super.initState();
  }

  void main() async {
    Future futureOfList = _getList();
    List<Product> list = await futureOfList;
    jsonDataGridSource = _JsonDataGridSource(list,type);
  }


  Future _getList() {
    ApiManagerTable apiManager1 = ApiManagerTable(Ms: Ms, Me: Me, type: type);
    return apiManager1.generateProductList();
  }



  // void refreshList() {
  //   setState(() {
  //     userDataFuture = ApiManager().generateProductList();
  //   });
  // }

  List<GridColumn> getColumns() {
    List<GridColumn> columns;

    if(type=="M00004"){
      columns = ([
        GridColumn(
          columnName: 'MEASURE_DT',
          width: 150,
          label: Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            child: const Text(
              '測量日期',
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          ),
        ),
        GridColumn(
          columnName: 'M00004',
          visible: true,
          // width: 150,
          label: Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            child:  const Text(
              "收縮壓",
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          ),
        ),
        GridColumn(
          columnName: 'M00005',
          visible: true,
          // width: 150,
          label: Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            child:  const Text(
              "舒張壓",
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          ),
        ),
      ]);
    }else{
      columns = ([
        GridColumn(
          columnName: 'MEASURE_DT',
          width: 150,
          label: Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            child: const Text(
              '測量日期',
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          ),
        ),
        GridColumn(
          columnName: 'MEASURE_VALUE',
          visible: true,
          // width: 150,
          label: Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            child:  Text(
              typeName,
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          ),
        ),
      ]);
    }



    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      // height: MediaQuery.of(context).size.height ,
      child: FutureBuilder(
          future: userDataFuture,
          // key: key,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return
                  SfDataGrid(
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
                      gridLinesVisibility: GridLinesVisibility.horizontal,
                      headerGridLinesVisibility: GridLinesVisibility.horizontal,

                      // columnWidthMode: ColumnWidthMode.fill,
                      // shrinkWrapRows: true,
                      // rowHeight: 40,
                      // headerRowHeight: 40,
                      // source: jsonDataGridSource1,
                      // columns: getColumns(),
                      // selectionMode: SelectionMode.single,
                      // onCellTap: (DataGridCellTapDetails details) {});

                      onCellTap: (DataGridCellTapDetails details) {
                        // TRANSACTION_SEQ1 = jsonDataGridSource
                        //     .effectiveRows[details.rowColumnIndex.rowIndex - 1]
                        //     .getCells()[1]
                        //     .value
                        //     .toString();
                        // MEASURE_DT1 = jsonDataGridSource
                        //     .effectiveRows[details.rowColumnIndex.rowIndex - 1]
                        //     .getCells()[0]
                        //     .value
                        //     .toString();
                        // //print(jsonDataGridSource.effectiveRows[details.rowColumnIndex.rowIndex - 1].getCells()[1].value.toString());
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (BuildContext context) {
                        //   return const JsonDataGridView1();
                        // }));
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

class _JsonDataGridSource extends DataGridSource {
  _JsonDataGridSource(this.productList,this.type) {
    buildDataGridRow();
  }




  List<DataGridRow> dataGridRows = [];
  List<Product> productList = [];

  String type="";
  List<DataGridCell<dynamic>> DataGridCellList=[];


  void buildDataGridRow() {

    if(type=="M00004"){
      dataGridRows = productList.map<DataGridRow>((dataGridRow) {
        return DataGridRow(cells: [
          DataGridCell<String>(columnName: 'MEASURE_DT', value: dataGridRow.MEASURE_DT),
          // DataGridCell<String>(
          //     columnName: 'TRANSACTION_SEQ', value: dataGridRow.TRANSACTION_SEQ),
          DataGridCell<String>(columnName: 'M00004', value: dataGridRow.M00004.toString().replaceAll(".0", "")),
          DataGridCell<String>(columnName: 'M00005', value: dataGridRow.M00005.toString().replaceAll(".0", "")),
          // DataGridCell<int>(
          //     columnName: 'M00002',
          //     value: double.parse(dataGridRow.M00002.toString()).toInt()),
          // DataGridCell<int>(
          //     columnName: 'M00003',
          //     value: double.parse(dataGridRow.M00003.toString()).toInt()),
          // DataGridCell<double>(columnName: 'freight', value: dataGridRow.freight),
        ]);
      }).toList(growable: false);
    }else{
      dataGridRows = productList.map<DataGridRow>((dataGridRow) {
        return DataGridRow(cells: [
          DataGridCell<String>(columnName: 'MEASURE_DT', value: dataGridRow.MEASURE_DT),
          // DataGridCell<String>(
          //     columnName: 'TRANSACTION_SEQ', value: dataGridRow.TRANSACTION_SEQ),
          DataGridCell<String>(columnName: 'MEASURE_VALUE', value: dataGridRow.MEASURE_VALUE.toString().replaceAll(".0", "")),
          // DataGridCell<int>(
          //     columnName: 'M00002',
          //     value: double.parse(dataGridRow.M00002.toString()).toInt()),
          // DataGridCell<int>(
          //     columnName: 'M00003',
          //     value: double.parse(dataGridRow.M00003.toString()).toInt()),
          // DataGridCell<double>(columnName: 'freight', value: dataGridRow.freight),
        ]);
      }).toList(growable: false);
    }



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