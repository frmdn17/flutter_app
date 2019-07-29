import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => new _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState(){
    super.initState();

    var initializationSettingsAndroid = new AndroidInitializationSettings('ic_launcher') ;
    var initializationSettingsIos = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIos);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Alarm Screen")
      ),
      body: new Container(
        padding: EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(onPressed: _notificationWithoutSounds,
              child: new Text('Alarm On Dummy'),
            )
          ],
        ),
      ),
    );
  }

  Future selectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_){
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("PayLoad: $Notification"),
        );
      }
    );
  }

  Future _notificationWithoutSounds() async {
    var androidPlatformChannelSpesifics = new AndroidNotificationDetails('0', 'Samsung A30', 'your channel description', playSound: false,
    importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpesifics = new IOSNotificationDetails(presentSound: false);
    var platformChannelSpesifics = new NotificationDetails(androidPlatformChannelSpesifics, iOSPlatformChannelSpesifics);
    await flutterLocalNotificationsPlugin.show(0, 'Hello World', 'Test Notifikasi', platformChannelSpesifics, payload: 'No_Sound');
  }
}
