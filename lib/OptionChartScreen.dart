import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

import 'BarChartScreen.dart';
import 'DonutChartScreen.dart';
import 'LineChartScreen.dart';
import 'PieChartScreen.dart';

class OptionChartScreen extends StatefulWidget {
  @override
  _OptionChartScreenState createState() => new _OptionChartScreenState();
}

class _OptionChartScreenState extends State<OptionChartScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: Text("Option Chart")
      ),
      body: new Container(
        padding: EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.all(8.0),
              decoration: new BoxDecoration(
                  border: Border.all(color: Colors.lightBlue)),
              child: new ListTile(
                title: new Text(
                  "Donut Test Chart",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new DonutChartScreen()));
                },
              ),
            ),
            new Container(
              padding: EdgeInsets.all(8.0),
              decoration: new BoxDecoration(
                  border: Border.all(color: Colors.lightBlue)),
              child: new ListTile(
                title: new Text(
                  "Bar Chart",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new BarChartScreen.withRandomData()));
                },
              ),
            ),
            new Container(
              padding: EdgeInsets.all(8.0),
              decoration: new BoxDecoration(
                  border: Border.all(color: Colors.lightBlue)),
              child: new ListTile(
                title: new Text(
                  "Pie Chart",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new PieChartScreen.withRandomData()));
                },
              ),
            ),
            new Container(
              padding: EdgeInsets.all(8.0),
              decoration: new BoxDecoration(
                  border: Border.all(color: Colors.lightBlue)),
              child: new ListTile(
                title: new Text(
                  "Line Chart",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new LineChartScreen.withRandomData()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
