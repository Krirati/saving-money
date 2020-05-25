import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:savemoney/constant.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DialogNotification extends StatefulWidget {
  @override
  _DialogNotificationState createState() => _DialogNotificationState();
}

class _DialogNotificationState extends State<DialogNotification>{
 FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  @override
  void initState() {
    super.initState();
    initializing();
  }

  void initializing() async {
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void _showNotifications() async {
    await notification();
    
  }

  void showNotificationsDaily(int id, int hour, int minute) async {
    await notificationDaily(id, hour, minute);
  }

  Future<void> notification() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'Channel ID', 'Channel title', 'channel body',
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'Hello there', 'please subscribe my channel', notificationDetails);
  }

  Future<void> notificationDaily (id, hour, minute) async {
    print('$hour : $minute: 0');
    var time = Time(hour, minute, 0);
    var androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'your channel id', 'your channel name', 'your channel description',
          importance: Importance.Max,
          priority: Priority.High,
          ticker: 'Medicine Reminder'
        );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id,
        'show daily title',
        'Daily notification shown at  $hour : $minute: 0 ',
        time,
        platformChannelSpecifics);
  }
  Future onSelectNotification(String payLoad) {
    print('Notification clicked');
    if (payLoad != null) {
      print(payLoad);
    }
    return Future.value(0);
    // we can set navigator to navigate another screen
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("");
            },
            child: Text("Okay")),
      ],
    );
  }

  bool _notification = false;
  bool _saving = false;
  bool _record = false;
  var pickedtime_saving;
  var pickedtime_record;

  @override
  Widget build(BuildContext context) {
    return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ), 
          elevation: 2,
          child: Wrap(
            children: <Widget>[
            Container(
            // height: height - 200,
            // width: width - 50,
            child: Stack(
              children: <Widget> [
                SafeArea(
                  minimum: EdgeInsets.symmetric(vertical: 15, horizontal:10 ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Setting Notification',
                            style: kHeadingTextStyle,),
                          Spacer(),
                          IconButton(
                              icon: Icon(Icons.clear, color: Colors.black, size: 30,),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }
                          ),
                        ],
                      ),
                      MergeSemantics(
                        child: ListTile(
                          title: Text('Notification'),
                          trailing: CupertinoSwitch(
                            value: _notification,
                            onChanged: (bool value) { setState(() { _notification = value; }); },
                          ),
                          onTap: () { 
                            setState(() { 
                              _notification = !_notification; 
                              }
                            );
                          },
                        ),
                      ),
                      MergeSemantics(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text('Reminder to saving'),
                              enabled: _notification,
                              trailing: CupertinoSwitch(
                                value: _saving,
                                onChanged: (bool value) { 
                                  if (_notification == true) {
                                    setState(() { 
                                        _saving = value; 
                                      }
                                    );
                                  }
                                },
                              ),
                              onTap: () { 
                                if (_notification == true) {
                                  setState(() { 
                                      _saving = !_saving; 
                                    }
                                  );
                                }
                              },
                            ),
                            Visibility(
                              visible: _saving,
                              child: ListTile(
                                title: Text('Time saving'),
                                enabled: _notification,
                                dense: true,
                                contentPadding: EdgeInsets.only(left: 20, right: 20),
                                trailing: GestureDetector(
                                  child: pickedtime_record == null ? 
                                    Text("Set Time") : 
                                    Text(pickedtime_record, 
                                      style: TextStyle(
                                        color: kTextLightColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  onTap: () {
                                    DatePicker.showTime12hPicker(context,
                                        showTitleActions: true,
                                        currentTime: DateTime.now(), 
                                        onConfirm: (time) {
                                          setState(() {
                                            pickedtime_record =
                                              "${time.hour} : ${time.minute} : ${time.second}";
                                            showNotificationsDaily(1,time.hour, time.minute);
                                            print(pickedtime_record);
                                          }
                                        );
                                      }
                                    );
                                  },
                                ) 
                              ),
                            )
                          ]
                        )
                      ),
                      MergeSemantics(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text('Reminder to record accounting'),
                              enabled: _notification,
                              trailing: CupertinoSwitch(
                                value: _record,
                                onChanged: (bool value) { 
                                  if (_notification == true) {
                                    setState(() { 
                                        _record = value; 
                                      }
                                    );
                                  }
                                },
                              ),
                              onTap: () { 
                                if (_notification == true) {
                                  setState(() { 
                                      _record = !_record; 
                                    }
                                  );
                                }
                              },
                            ),
                            Visibility(
                              visible: _record,
                              child: ListTile(
                                title: Text('Time accounting'),
                                enabled: _notification,
                                dense: true,
                                contentPadding: EdgeInsets.only(left: 20, right: 20),
                                trailing: GestureDetector(
                                  child: pickedtime_saving == null ? 
                                    Text("Set Time") : 
                                    Text(pickedtime_record, 
                                      style: TextStyle(
                                        color: kTextLightColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  onTap: () {
                                    DatePicker.showTime12hPicker(context,
                                        showTitleActions: true,
                                        currentTime: DateTime.now(), onConfirm: (time) {
                                      setState(() {
                                        pickedtime_saving =
                                            "${time.hour} : ${time.minute} : ${time.second}";
                                        showNotificationsDaily(2,time.hour, time.minute);
                                      });
                                    });
                                  },
                                ) 
                              ),
                            )
                          ]
                        ),
                      ),
                    ]
                  ),
                )
              ]
            ),
          )
        ]
        )
      );
  }

}