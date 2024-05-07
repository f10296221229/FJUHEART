import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../model/ChartData.dart';
import '../service/ApiManagerChart.dart';
import '../service/PostProvider.dart';


class NewGraphWidgetProvide extends StatefulWidget {
  const NewGraphWidgetProvide({super.key, required this.Ms,required this.Me,required this.type,required this.typeName});
  final String Ms;
  final String Me;
  final String type;
  final String typeName;
  @override
  State<NewGraphWidgetProvide> createState() => _NewGraphWidgetProvideState(Ms: Ms, Me: Me, type: type, typeName: typeName);
}

class _NewGraphWidgetProvideState extends State<NewGraphWidgetProvide> {
  _NewGraphWidgetProvideState({required this.Ms,required this.Me,required this.type,required this.typeName});
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

    super.initState();
  }

  void main()  {
    if(type=="M00004"){
      seriesList.clear();
      charts.clear();
      List<ChartData> list = context.watch<PostProvider>().posts;
      list=list.reversed.toList();
      for (int i = 0; i < list.length; i++) {
        charts.add(list[i]);
      }

      // charts.reversed.toList();

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
      seriesList.clear();
      charts.clear();

      List<ChartData> list = context.watch<PostProvider>().posts;
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
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
          main();
          // return b;
          return SfCartesianChart(
              legend: const Legend(
                isVisible: true,
              ),
              enableSideBySideSeriesPlacement: false,
              primaryXAxis: const CategoryAxis(
                arrangeByIndex: false,
                interval: 1,
                labelRotation: 110,
                labelStyle: TextStyle(fontSize: 10),
              ),
              tooltipBehavior: _tooltipBehavior,
              series: seriesList

          );
        },

      );
  }
}



