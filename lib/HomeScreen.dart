import 'package:flutter/material.dart';
import 'package:flutter_app/LoginPage.dart';
import 'package:flutter_app/TodoScreen.dart';
import 'package:flutter_app/AboutScreen.dart';
import 'AlarmScreen.dart';
import 'BarChartScreen.dart';
import 'LineChartScreen.dart';
import 'OptionChartScreen.dart';
import 'PieChartScreen.dart';
import 'PostsScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  int pos = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
        ),
        body: new Container(
          alignment: Alignment.center,
          child: new Text("Halo \n" + new DateTime.now().toString(),
              style: new TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        drawer: Drawer(
            child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Text('Hello World', style: new TextStyle(
                        fontSize: 24, color: Colors.white)),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  ListTile(
                    title: Text('About'),
                    leading: Icon(
                        Icons.info
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          BuildContext context) => new AboutScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                        Icons.photo
                    ),
                    title: Text('To Do'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) => new TodoScreen()));
                    },
                  ),
                  ListTile(
                    title: Text('Post'),
                    leading: Icon(
                      Icons.photo_album
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) => new PostsScreen()));
                    },
                  ),
                  ListTile(
                    title: Text('Chart'),
                    leading: Icon(
                      Icons.multiline_chart
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => new OptionChartScreen()));
                    }
                  ),
                  ListTile(
                    title: Text('Alarm'),
                    leading: Icon(
                        Icons.watch
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) => new AlarmScreen()));
                    },
                  ),
                  ListTile(
                    title: Text('Logout'),
                    leading: Icon(
                        Icons.exit_to_app
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) => new LoginPage()));
                    },
                  ),
                ]
            )

        )
    );
  }
}