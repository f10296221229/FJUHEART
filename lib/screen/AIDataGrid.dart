import 'package:devtest01/partition/NewGraphWidgetProvide.dart';
import 'package:devtest01/partition/NewTableWidgetProvide.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../Icon/MyFlutterApp.dart';
import '../model/Product.dart';
import '../partition/AIDataGridInner.dart';
import '../partition/ListBuilder.dart';
import '../partition/TextSectionDate.dart';
import '../service/PostProvider.dart';

class AIDataGrid extends StatefulWidget {
  const AIDataGrid(
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
  State<AIDataGrid> createState() =>
      _AIDataGridState(Ms: Ms, Me: Me, type: type, typeName: typeName);
}

class _AIDataGridState extends State<AIDataGrid> {
  _AIDataGridState(
      {required this.Ms,
      required this.Me,
      required this.type,
      required this.typeName});

  final String Ms;
  final String Me;
  final String type;
  final String typeName;

  bool _isGridMode = true;
  bool _selectMode = true;




  @override
  void initState() {
    // context.read<PostProvider>().AIData();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan,
        leading: Row(
          children: [
            _selectMode
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
                        })
          ],
        ),
        title: Text(
          typeName,
          style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          textAlign: TextAlign.center,
        ),
      ),
      body: _isGridMode ?
      const AIDataGridInner()
      : const ListBuilder(),
    );
  }
}
