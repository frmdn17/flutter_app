import 'package:flutter/material.dart';
import 'package:get_version/get_version.dart';
import 'package:flutter/services.dart';

class AboutScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutScreen();

}


class _AboutScreen extends State<AboutScreen> {
  String _platformVersion = 'unknown';
  String _projectVersion = '';
  String _projectName = '';

  @override
  initState(){
    super.initState();
    initPlatformState();
  }

  initPlatformState() async{
    String platformVersion;
    try{
      platformVersion = await GetVersion.platformVersion;
    }on PlatformException{
      platformVersion = 'Failed To Get Version';
    }
    String projectVersion;
    try{
      projectVersion = await GetVersion.projectVersion;
    }on PlatformException{
      projectVersion = 'Failed To Get Version';
    }
    String projectName;
    try{
      projectName = await GetVersion.appName;
    }on PlatformException{
      projectName = 'Failed To Get Version';
    }
    if(!mounted) return;

    setState((){
    _platformVersion = platformVersion;
    _projectVersion = projectVersion;
    _projectName = projectName;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About App'),
      ),
      body: new SingleChildScrollView(
        child: _body(),
      ),
    );
  }


  Widget _body() {
      return new Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: new ListBody(
          children: <Widget>[
            new ListTile(
              title: Text('PT. Inovasi Solusindo', style: new TextStyle(fontSize: 14.0)),
              leading: Icon(Icons.build),
            ),
            Divider(),
            new ListTile(
              title: Text(_projectName, style: new TextStyle(fontSize: 14.0)),
              leading: Icon(Icons.info_outline),
            ),
            Divider(),
            new ListTile(
              title: Text(_platformVersion, style: new TextStyle(fontSize: 14.0)),
              leading: Icon(Icons.android),
            ),
            Divider(),
            new ListTile(
              title: Text('Version : ' + _projectVersion, style: new TextStyle(fontSize: 14.0)),
              leading: Icon(Icons.confirmation_number),
            ),
            Divider(),
          ],
        ),
      );
  }

}
