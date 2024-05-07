import 'package:devtest01/partition/NewGraphWidgetProvide.dart';
import 'package:devtest01/partition/NewTableWidgetProvide.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../partition/ListBuilder.dart';
import '../partition/TextSectionDate.dart';
import '../service/PostProvider.dart';

class ChartDataGrid extends StatefulWidget {
  const ChartDataGrid({super.key, required this.Ms,required this.Me,required this.type,required this.typeName});
  final String Ms;
  final String Me;
  final String type;
  final String typeName;

  @override
  State<ChartDataGrid> createState() => _ChartDataGridState(Ms: Ms, Me: Me, type: type, typeName: typeName);
}

class _ChartDataGridState extends State<ChartDataGrid> {
  _ChartDataGridState({required this.Ms,required this.Me,required this.type,required this.typeName});
  final String Ms;
  final String Me;
  final String type;
  final String typeName;


  bool _isGridMode = true;
  bool _selectMode = true;

  @override
  void initState() {

    if(type=="M00004"){
      context.read<PostProvider>().fetchData1(Ms,Me,type);
    }else{
      context.read<PostProvider>().fetchData(Ms,Me,type);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    //   final result = await Navigator.pushReplacement(
    //     context,
    //     // Create the SelectionScreen in the next step.
    //     MaterialPageRoute(builder: (context) => const HomeScreen()),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
         backgroundColor: Colors.cyan
        ,leading:
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
        ,title:  Text(typeName
          ,style: const TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1))
          ,textAlign: TextAlign.center,
      ),
      ),
      body: _isGridMode ?
      Container(
        color: Color(int.parse("dfe6f0", radix: 16)).withAlpha(255),
        child: ListView(children: <Widget>[
          PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (didPop) {
                return;
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Click once more to go back"),
                    duration: Duration(milliseconds: 1500),
                  ),
                );
              }
            },
            child: const Text(''),
          ),
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
                TextSectionDate(
                    Ms: Ms,
                    Me: Me,
                    type: type,
                    typeName: typeName
                ),
              ],
            ),
          ),
          const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.favorite,
                  color: Colors.pink,
                  size: 28.0,
                  //semanticLabel: 'Text to announce in accessibility modes',
                ),
                Divider(),
                Text(
                  '圖表',
                  style: TextStyle(fontSize: 28.0, height: 2),
                )
              ]),
          Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child:  NewGraphWidgetProvide(
                  Ms: Ms,
                  Me: Me,
                  type: type,
                  typeName: typeName,
                ),
              )),
          const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child:   NewTableWidgetProvideWidget(
              Ms: Ms,
              Me: Me,
              type: type,
              typeName: typeName,
            ),
          ),

        ]),
      ) : const ListBuilder(),
    );
  }
}


