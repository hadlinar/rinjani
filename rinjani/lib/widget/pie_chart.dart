import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rinjani/models/visit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  Activity activity;

  Chart(this.activity);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late int inOffice = int.parse(widget.activity.prs_in);
  late int out = int.parse(widget.activity.prs_out);
  late int off = int.parse(widget.activity.prs_off);

  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('In Office', inOffice),
      ChartData('Out Office', out),
      ChartData('Off', off)
    ];
    return Scaffold(
        body: Center(
            child: Container(
                child: SfCircularChart(
                    series: <CircularSeries>[
                      PieSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y
                      )
                    ]
                )
            )
        )
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}