import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChartScreen extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  factory BarChartScreen.withSampleData(){
    return new BarChartScreen(
      createSampleData(),

      animate: false,
    );
  }

  factory BarChartScreen.withRandomData(){
    return new BarChartScreen(createRandomData());
  }

  static List<charts.Series<Spending, String>> createRandomData(){
    final random = new Random();

    final data = [
      new Spending('2013', random.nextInt(1000000)),
      new Spending('2014', random.nextInt(1000000)),
      new Spending('2015', random.nextInt(1000000)),
      new Spending('2016', random.nextInt(1000000)),
      new Spending('2017', random.nextInt(1000000)),
      new Spending('2018', random.nextInt(1000000)),
      new Spending('2019', random.nextInt(1000000)),
    ];

    return[
      new charts.Series(id: 'Spending',
          data: data,
          domainFn: (Spending sp, _) => sp.year,
          measureFn: (Spending sp , _) => sp.spending,
          labelAccessorFn: (Spending sp, _) => '${sp.year}: \$${sp.spending}'
      )
    ];
  }

  BarChartScreen(this.seriesList , {this.animate});
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Bar Chart")
      ),
      body: new Padding(
        padding: EdgeInsets.all(8.0),
        child: new charts.BarChart(
            seriesList,
            animate: animate,
            vertical: true,
        ),
      ),
    );
  }

  static List<charts.Series<Spending , String>> createSampleData(){

    final data = [
      new Spending ('2013', 5),
      new Spending ('2014', 25),
      new Spending ('2015', 100),
      new Spending ('2016', 75),
      new Spending ('2017', 25),
      new Spending ('2018', 5),
      new Spending ('2019' , 100),
    ];
    return[
      new charts.Series(id: 'Spending',
          data: data,
          domainFn: (Spending sp, _) => sp.year,
          measureFn: (Spending sp , _) => sp.spending,
          labelAccessorFn: (Spending sp, _) => '${sp.year}: \$${sp.spending}'
      )
    ];
  }
}
class Spending{
  final String year;
  final int spending;

  Spending(this.year,this.spending);
}
