import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notify extends StatefulWidget {
  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//-----------------------------------------------------------------------------
  // scheduled notification method:
  void notifySchedule() async{
    var scheduledNotificationDateTime = new DateTime.now().add(new Duration(seconds: 10));
    var android1 = new AndroidNotificationDetails('channel id',
        'channel NAME', 'CHANNEL DESCRIPTION');
    var iOS1 = new IOSNotificationDetails();
    NotificationDetails platform = new NotificationDetails(android1, iOS1);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Garage notifiaction',
        'Reservation Alert',
        scheduledNotificationDateTime, platform,payload:'you are about 30 minutes off !' );
  }
//--------------------------------------------------------------------------------
  //show notification on pressed:
  showNotification() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High,importance: Importance.Max
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Garage notifiaction', 'Reservation Alert', platform,
        payload: 'you are about 30 minutes off !');
  }
//--------------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,onSelectNotification: onSelectNotification);

  }

   Future onSelectNotification(String payload) {

    return showDialog(
      context: context,
      builder: (_) =>  AlertDialog(
        actions: <Widget>[
          FlatButton(onPressed: (){ Navigator.of(context).pop();}, child: Text('Ok'),)
        ],
        title: new Text('Notification'),
        content: new Text('$payload'),
      ),
    );
  }
  //--------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notify'),
        centerTitle: true,
      ),
      body: Center(
        child: RaisedButton(
        onPressed: showNotification,
        child: new Text(
          'Notify',
          style: Theme.of(context).textTheme.headline,
        ),
        ),
      ),
    );
  }
}
