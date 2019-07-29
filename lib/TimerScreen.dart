//import 'package:flutter/material.dart';
//import 'package:android_alarm_manager/android_alarm_manager.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'dart:async';
//
//class TimerScreen extends StatefulWidget {
//  @override
//  _TimerScreenState createState() => new _TimerScreenState();
//}
//
//class _TimerScreenState extends State<TimerScreen> {
//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
//
//  main() async{
//    final int alarmID = 0;
//    await AndroidAlarmManager.initialize();
//    await AndroidAlarmManager.periodic(Duration(minutes: 1), alarmID, printNotif);
//  }
//
//  void printNotif() async {
//
//    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//    var androidPlatformChannelSpesifics = new AndroidNotificationDetails('0', 'Samsung A30', 'your channel description', playSound: false,
//        importance: Importance.Max, priority: Priority.High);
//    var iOSPlatformChannelSpesifics = new IOSNotificationDetails(presentSound: false);
//    var platformChannelSpesifics = new NotificationDetails(androidPlatformChannelSpesifics, iOSPlatformChannelSpesifics);
//    await flutterLocalNotificationsPlugin.show(0, 'Hello World', 'Test Notifikasi', platformChannelSpesifics, payload: 'No_Sound');
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Container(
//
//    );
//  }
//}
