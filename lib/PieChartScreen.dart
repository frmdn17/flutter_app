import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';
import 'dart:async';

class PieChartScreen extends StatelessWidget {
  List<charts.Series> seriesList;
  final bool animate;

  PieChartScreen(this.seriesList, {this.animate});

  factory PieChartScreen.withSampleData(){
    return new PieChartScreen(
      createSampleData(),
      animate: false,
    );
  }

  factory PieChartScreen.withRandomData(){
    return PieChartScreen(createRandomData());
  }

  static List<charts.Series<Spending, int>> createRandomData() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      print("Hello");

    });
    final random = new Random();
    BuildContext context;
    final data = [
      new Spending(2014, random.nextInt(1000000)),
      new Spending(2015, random.nextInt(1000000)),
      new Spending(2016, random.nextInt(1000000)),
      new Spending(2017, random.nextInt(1000000)),
      new Spending(2018, random.nextInt(1000000)),
      new Spending(2019, random.nextInt(1000000)),
    ];
    return [
      new charts.Series(id: 'Spending',
          data: data,
          domainFn: (Spending sp, _) => sp.year,
          measureFn: (Spending sp, _) => sp.spending,
          labelAccessorFn: (Spending sp, _) => '${sp.year} : ${sp.spending}'
      )
    ];
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: Text("Pie Chart Screen")
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: new charts.PieChart(seriesList,
          animate: animate,
          defaultRenderer: new charts.ArcRendererConfig(
              arcRendererDecorators: [
                new charts.ArcLabelDecorator(
                    labelPosition: charts.ArcLabelPosition.auto)
              ]),
        ),
      ),
    );
  }

  static List<charts.Series<Spending, int>> createSampleData() {
    final data = [
      new Spending(2014, 5),
      new Spending(2015, 25),
      new Spending(2016, 50),
      new Spending(2017, 100),
      new Spending(2018, 75),
      new Spending(2019, 25),
    ];

    return [
      new charts.Series(id: 'Spending',
          data: data,
          domainFn: (Spending sp, _) => sp.year,
          measureFn: (Spending sp, _) => sp.spending,
          labelAccessorFn: (Spending sp, _) => '${sp.year} \n : ${sp.spending}'
      )
    ];
  }
}

class Spending {
  final int year;
  final int spending;

  Spending(this.year, this.spending);
}
