import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

class DonutChartScreen extends StatefulWidget {

  @override
  _DonutChartScreenState createState() => new _DonutChartScreenState();

}


class _DonutChartScreenState extends State<DonutChartScreen> {
  _DonutChartScreenState();


  List<charts.Series> seriesList;
  int changeCounter = 0;

   _DonutChartScreenState.withSampleData(){
     createSampleData();
  }

   _DonutChartScreenState.withRandomData(){
    new Timer.periodic(Duration(seconds: 5), (timer) => setState((){
      createRandomData();
    }));
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


  static List<charts.Series<Spending, int>> createRandomData() {

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
          defaultRenderer: new charts.ArcRendererConfig(
              arcRendererDecorators: [
                new charts.ArcLabelDecorator(
                    labelPosition: charts.ArcLabelPosition.auto)
              ]),
        ),
      ),
    );
  }

}

class Spending {
  final int year;
  final int spending;

  Spending(this.year, this.spending);
}