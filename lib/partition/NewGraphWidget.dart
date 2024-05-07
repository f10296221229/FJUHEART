import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../model/ChartData.dart';
import '../service/ApiManagerChart.dart';
import '../service/PostProvider.dart';


class NewGraphWidget extends StatefulWidget {
  const NewGraphWidget({super.key, required this.Ms,required this.Me,required this.type,required this.typeName});
  final String Ms;
  final String Me;
  final String type;
  final String typeName;
  @override
  State<NewGraphWidget> createState() => _NewGraphWidgetState(Ms: Ms, Me: Me, type: type, typeName: typeName);
}

class _NewGraphWidgetState extends State<NewGraphWidget> {
  _NewGraphWidgetState({required this.Ms,required this.Me,required this.type,required this.typeName});
  late Future<dynamic> userDataFuture;
  List<ChartData> charts = [];
  List<ChartData> charts1 = [];
  late TooltipBehavior _tooltipBehavior;

  final String Ms;
  final String Me;
  final String type;
  final String typeName;

  List<CartesianSeries<dynamic, dynamic>> seriesList=[];

  @override
  void initState() {

    _tooltipBehavior = TooltipBehavior(
        enable: true
        ,header: '時間/$typeName'
        ,tooltipPosition: TooltipPosition.pointer
        ,format:'point.x / point.y'
    );
    main();
    if(type=="M00004"){
      userDataFuture = ApiManagerChart(Ms: Ms, Me: Me, type: type).generateProductList1();
    }else{
      userDataFuture = ApiManagerChart(Ms: Ms, Me: Me, type: type).generateProductList();
    }

    // context.read<PostProvider>().fetchData(Ms,Me,type);

    super.initState();
  }

  void main() async {
    if(type=="M00004"){

      Future<List<ChartData>> futureOfList = _getList1(Ms,Me,type);
      List<ChartData> list = await futureOfList;
      for (int i = 0; i < list.length; i++) {
        charts.add(list[i]);
      }


      // List<ChartData> list1 = list[0];
      //
      // for (int i = 0; i < list1.length; i++) {
      //   charts.add(list1[i]);
      // }
      //
      // List<ChartData> list2 = list[1];
      //
      // for (int i = 0; i < list2.length; i++) {
      //   charts1.add(list2[i]);
      // }

      seriesList.add(LineSeries<ChartData, Object>(
          dataSource: charts,
          enableTooltip: true,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          name:"收縮壓",
          color: Colors.red,
          // Render the data label
          dataLabelSettings:
          const DataLabelSettings(isVisible: true))
      );

      seriesList.add(LineSeries<ChartData, Object>(
          dataSource: charts,
          enableTooltip: true,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y1,
          name:"舒張壓",
          color: Colors.blue,
          // Render the data label
          dataLabelSettings:
          const DataLabelSettings(isVisible: true))
      );


    }else{

      Future<List<ChartData>> futureOfList = _getList(Ms,Me,type);
      List<ChartData> list = await futureOfList;
      for (int i = 0; i < list.length; i++) {
        charts.add(list[i]);
      }

      seriesList.add(LineSeries<ChartData, Object>(
          dataSource: charts,
          enableTooltip: true,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          name:typeName,
          color: Colors.red,
          // Render the data label
          dataLabelSettings:
          const DataLabelSettings(isVisible: true))
      );
    }




  }

  Future<List<ChartData>> _getList(String a,String b,String c) {
    ApiManagerChart apiManager1 = ApiManagerChart(Ms: a, Me: b, type: c);
    return apiManager1.generateProductList();
  }

  Future<List<ChartData>> _getList1(String a,String b,String c) {
    ApiManagerChart apiManager1 = ApiManagerChart(Ms: a, Me: b, type: c);
    return apiManager1.generateProductList1();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userDataFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {

            // print(snapshot.hasData);
            // print(snapshot.connectionState);
            // print(ConnectionState.done);

            if (snapshot.hasData) {
              return SfCartesianChart(
                  legend: const Legend(
                    isVisible: true,
                    // image: AssetImage('images/truck_legend.png'),
                  ),
                  enableSideBySideSeriesPlacement: false,
                  // title: ChartTitle(text: typeName),
                  // Initialize category axis
                  primaryXAxis: const CategoryAxis(
                    arrangeByIndex: false,
                    interval: 2,
                    labelRotation: 110,
                    labelStyle: TextStyle(fontSize: 10),
                  ),
                  // primaryXAxis: DateTimeAxis(
                  //   interval: 0.5,
                  //     // intervalType: DateTimeIntervalType.days
                  // ),
                  tooltipBehavior: _tooltipBehavior,
                  series: seriesList
                    // Initialize line series
                    // LineSeries<ChartData, Object>(
                    //     dataSource: charts,
                    //     enableTooltip: true,
                    //     xValueMapper: (ChartData data, _) => data.x,
                    //     yValueMapper: (ChartData data, _) => data.y,
                    //     // Render the data label
                    //     dataLabelSettings:
                    //         const DataLabelSettings(isVisible: true))
                  );
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



