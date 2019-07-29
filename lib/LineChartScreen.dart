import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class LineChartScreen extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  LineChartScreen(this.seriesList, {this.animate});

  factory LineChartScreen.withSampleData(){
    return new LineChartScreen(
      createSampleData(),

      animate: false,
    );
  }

  factory LineChartScreen.withRandomData(){
    return new LineChartScreen(
      createRandomData(),
    );
  }

  static List<charts.Series<LinearSpending, num>> createRandomData() {
    final random = new Random();

    final data = [
      new LinearSpending(0, random.nextInt(1000000)),
      new LinearSpending(1, random.nextInt(1000000)),
      new LinearSpending(2, random.nextInt(1000000)),
      new LinearSpending(3, random.nextInt(1000000)),
      new LinearSpending(4, random.nextInt(1000000)),
      new LinearSpending(5, random.nextInt(1000000)),
      new LinearSpending(6, random.nextInt(1000000)),
    ];
    return [
      new charts.Series<LinearSpending, int>(
        domainFn: (LinearSpending spending, _) => spending.month,
        id: 'Spending',
        data: data,
          labelAccessorFn: (LinearSpending sp, _) => '${sp.month} : ${sp.spending}',
          measureFn: (LinearSpending spending, _) => spending.spending,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () async{
      return Scaffold(
          appBar: AppBar(
          title: Text("Chart Screen")
      ),
      body: new Padding(
        padding: EdgeInsets.all(16.0),
          child: new charts.LineChart(seriesList, animate: animate, behaviors:[
            new charts.RangeAnnotation([
              new charts.LineAnnotationSegment(
                20, charts.RangeAnnotationAxisType.measure,
                endLabel: 'January - July',
                color: charts.MaterialPalette.gray.shade300
              ),
              new charts.LineAnnotationSegment(
                1.0, charts.RangeAnnotationAxisType.domain,
                endLabel: '1 - 1.000.000',
                color: charts.MaterialPalette.gray.shade400
              ),
            ]),
          ]),
        ));
      }
    );
    return Scaffold(
      appBar: AppBar(
          title: Text("Chat Screen")
      ),
      body: new Padding(
        padding: EdgeInsets.all(16.0),
        child: new charts.LineChart(seriesList, animate: animate, behaviors:[
          new charts.RangeAnnotation([
         new charts.LineAnnotationSegment(
                20, charts.RangeAnnotationAxisType.measure,
                startLabel: 'Bulan',
                endLabel: 'Januari - July',
                color: charts.MaterialPalette.gray.shade300
            ),
            new charts.LineAnnotationSegment(
                0, charts.RangeAnnotationAxisType.domain,
                startLabel: 'Pengeluaran',
                endLabel: '1 - 1.000.000',
                color: charts.MaterialPalette.gray.shade400
            ),
          ]),
        ]),
      ),
    );
  }

  static List<charts.Series<LinearSpending, int>> createSampleData() {
    final data = [
      new LinearSpending(1, 5),
      new LinearSpending(2, 25),
      new LinearSpending(3, 100),
      new LinearSpending(4, 75),
      new LinearSpending(5, 25),
      new LinearSpending(6, 100),
      new LinearSpending(7, 75),
    ];
    return [
      new charts.Series<LinearSpending, int>(
        id: 'Spending',
        domainFn: (LinearSpending spending, _) => spending.month,
        measureFn: (LinearSpending spending, _) => spending.spending,
        data: data,
        labelAccessorFn: (LinearSpending sp, _) => '${sp.month} : ${sp.spending}'

      )
    ];
  }
}

class LinearSpending {
  final int month;
  final int spending;

  LinearSpending(this.month, this.spending);
}


