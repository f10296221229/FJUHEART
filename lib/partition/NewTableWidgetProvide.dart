import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../model/ChartData.dart';
import '../model/Product.dart';
import '../service/ApiManagerTable.dart';
import '../service/PostProvider.dart';

class NewTableWidgetProvideWidget extends StatefulWidget {
  const NewTableWidgetProvideWidget(
      {super.key,
      required this.Ms,
      required this.Me,
      required this.type,
      required this.typeName});

  final String Ms;
  final String Me;
  final String type;
  final String typeName;

  @override
  State<NewTableWidgetProvideWidget> createState() =>
      _NewTableWidgetProvideState(
          Ms: Ms, Me: Me, type: type, typeName: typeName);
}

class _NewTableWidgetProvideState extends State<NewTableWidgetProvideWidget> {
  _NewTableWidgetProvideState(
      {required this.Ms,
      required this.Me,
      required this.type,
      required this.typeName});

  // late Future<dynamic> userDataFuture;

  final String Ms;
  final String Me;
  final String type;
  final String typeName;

  late _JsonDataGridSource jsonDataGridSource;

  @override
  void initState() {
    super.initState();
  }

  void main() {
    List<Product> list = context.watch<PostProvider>().tables;

    if (type == "M00004") {
      jsonDataGridSource = _JsonDataGridSource(list, type);
    }else{
      jsonDataGridSource = _JsonDataGridSource(list.reversed.toList(), type);
    }
  }

  List<GridColumn> getColumns() {
    List<GridColumn> columns;
    if (type == "M00004") {
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
            child: const Text(
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
            child: const Text(
              "舒張壓",
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          ),
        ),
      ]);
    } else {
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
            child: Text(
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
      child: Builder(builder: (BuildContext context) {
        main();
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
      }),
    );
  }
}

class _JsonDataGridSource extends DataGridSource {
  _JsonDataGridSource(this.productList, this.type) {
    buildDataGridRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<Product> productList = [];

  String type = "";
  // List<DataGridCell<dynamic>> DataGridCellList = [];

  void buildDataGridRow() {
    if (type == "M00004") {
      dataGridRows = productList.map<DataGridRow>((dataGridRow) {
        return DataGridRow(cells: [
          DataGridCell<String>(
              columnName: 'MEASURE_DT', value: dataGridRow.MEASURE_DT),
          // DataGridCell<String>(
          //     columnName: 'TRANSACTION_SEQ', value: dataGridRow.TRANSACTION_SEQ),
          DataGridCell<String>(
              columnName: 'M00004',
              value: dataGridRow.M00004.toString().replaceAll(".0", "")),
          DataGridCell<String>(
              columnName: 'M00005',
              value: dataGridRow.M00005.toString().replaceAll(".0", "")),
          // DataGridCell<int>(
          //     columnName: 'M00002',
          //     value: double.parse(dataGridRow.M00002.toString()).toInt()),
          // DataGridCell<int>(
          //     columnName: 'M00003',
          //     value: double.parse(dataGridRow.M00003.toString()).toInt()),
          // DataGridCell<double>(columnName: 'freight', value: dataGridRow.freight),
        ]);
      }).toList(growable: false);

      // dataGridRows.reversed.toList();

    } else {
      dataGridRows = productList.map<DataGridRow>((dataGridRow) {
        return DataGridRow(cells: [
          DataGridCell<String>(
              columnName: 'MEASURE_DT', value: dataGridRow.MEASURE_DT),
          // DataGridCell<String>(
          //     columnName: 'TRANSACTION_SEQ', value: dataGridRow.TRANSACTION_SEQ),
          DataGridCell<String>(
              columnName: 'MEASURE_VALUE',
              value: dataGridRow.MEASURE_VALUE.toString().replaceAll(".0", "")),
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
