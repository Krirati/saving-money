import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:savemoney/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  bool _notification = false;
  bool _saving = false;
  bool _record = false;
  var pickedtime_saving;
  var pickedtime_record;
  @override
  void initState() {
    super.initState();
    initializing();    
    getSF();
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

  void showNotificationsDaily(int id, int hour, int minute) async {
    await notificationDaily(id, hour, minute);
  }

  Future<void> notificationDaily (id, hour, minute) async {
    print('$hour : $minute: 0');
    var time = Time(hour, minute, 0);
    var androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'repeatDailyAtTime channel id', 
          'repeatDailyAtTime channel name', 
          'repeatDailyAtTime description',
          importance: Importance.Max,
          priority: Priority.High,
          ticker: 'Medicine Reminder'
        );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id,
        'KEB TANG',
        'Remind to save the program  $hour : $minute: 0 ',
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


  getSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _notification = prefs.getBool('notification');
    if (_notification == null) {
      setState(() {
        _notification = false;
      });
    }
    _saving = prefs.getBool('saving_status');
    if (_saving == null) {
     setState(() {
       _saving = false;
     }); 
    }
    _record = prefs.getBool('record_status');
    if (_record == null) {
      setState(() {
        _record = false;
      });
    }
    pickedtime_saving = prefs.getString('saving_time');
    pickedtime_record = prefs.getString('record_time');
    print('$_notification $_saving $_record');
  }
  addBoolNotificationToSF(_notification) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notification', _notification);
  }
  addBoolSavingToSF(_saving) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('saving_status', _saving);
  }
  addTimeSavingToSF(timeSaving) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('saving_time', timeSaving);
  }
  addBoolRecordToSF(_record) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('record_status', _record);
  }
  addTimeRecordToSF(timeRecord) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('record_time', timeRecord);
  }
  DateTime _dateTime = DateTime.now();
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
                      FutureBuilder(
                        future: getSF(),
                        builder: (context, snapshot) {
                          return                       MergeSemantics(
                        child: ListTile(
                          title: Text('Notification'),
                          trailing: CupertinoSwitch(
                            value: _notification,
                            onChanged: (bool value) { 
                              setState(() { 
                                _notification = value;
                                addBoolNotificationToSF(_notification);
                                if (value == false) {
                                  _saving = false;
                                  _record = false;
                                  addBoolRecordToSF(_record);
                                  addBoolSavingToSF(_saving);
                                }
                              }
                              ); 
                            },
                          ),
                          onTap: () { 
                            setState(() { 
                              _notification = !_notification;
                              addBoolNotificationToSF(_notification);
                              }
                            );
                          },
                        ),
                      );
                        }
                      ),
                      FutureBuilder(
                        future: getSF(),
                        builder: (context, snapshot) {
                          return MergeSemantics(
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
                                            addBoolSavingToSF(_saving);
                                          }
                                        );
                                      }
                                    },
                                  ),
                                  onTap: () { 
                                    if (_notification == true) {
                                      setState(() { 
                                          _saving = !_saving;
                                          addBoolSavingToSF(_saving); 
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
                                      child: pickedtime_saving == null ? 
                                        Text("Set Time") : 
                                        Text(pickedtime_saving, 
                                          style: TextStyle(
                                            color: kTextLightColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      onTap: () async{
                                        // DatePicker.showTime12hPicker(context,
                                        //     showTitleActions: true,
                                        //     currentTime: DateTime.now(), 
                                        //     onConfirm: (time) {
                                        //       setState(() {
                                        //         pickedtime_saving =
                                        //           "${time.hour} : ${time.minute} : ${time.second}";
                                        //         showNotificationsDaily(1,time.hour, time.minute);
                                        //         print(pickedtime_saving);
                                        //         addTimeSavingToSF(pickedtime_saving);
                                        //       }
                                        //     );
                                        //   }
                                        // );
                                        await showModalBottomSheet(
                                          context: context, 
                                          builder: (BuildContext context) {
                                            return CupertinoDatePicker(
                                              mode: CupertinoDatePickerMode.time,
                                              initialDateTime: _dateTime,
                                              backgroundColor: Colors.white,
                                              onDateTimeChanged: (dateTime) {
                                                print(dateTime);
                                                setState(() {
                                                  pickedtime_saving =
                                                    "${dateTime.hour} : ${dateTime.minute} : ${dateTime.second}";
                                                  showNotificationsDaily(1,dateTime.hour, dateTime.minute);
                                                  print(pickedtime_saving);
                                                  addTimeSavingToSF(pickedtime_saving);
                                                });
                                              },

                                            );
                                          }
                                        );
                                      },
                                    ) 
                                  ),
                                )
                              ]
                            )
                          );
                      }),
                      FutureBuilder(
                        future: getSF(),
                        builder: (context, snapshot) {
                          return MergeSemantics(
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
                                            addBoolRecordToSF(_record);
                                          }
                                        );
                                      }
                                    },
                                  ),
                                  onTap: () { 
                                    if (_notification == true) {
                                      setState(() { 
                                          _record = !_record; 
                                          addBoolRecordToSF(_record);
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
                                      child: pickedtime_record == null ? 
                                        Text("Set Time") : 
                                        Text(pickedtime_record, 
                                          style: TextStyle(
                                            color: kTextLightColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      onTap: () async{
                                        // DatePicker.showTime12hPicker(context,
                                        //     showTitleActions: true,
                                        //     currentTime: DateTime.now(), onConfirm: (time) {
                                        //   setState(() {
                                        //     pickedtime_record =
                                        //         "${time.hour} : ${time.minute} : ${time.second}";
                                        //     showNotificationsDaily(2,time.hour, time.minute);
                                        //     addTimeRecordToSF(pickedtime_record);
                                        //   });
                                        // });
                                        await showModalBottomSheet(
                                          context: context, 
                                          builder: (BuildContext context) {
                                            return CupertinoDatePicker(
                                              mode: CupertinoDatePickerMode.time,
                                              initialDateTime: _dateTime,
                                              backgroundColor: Colors.white,
                                              onDateTimeChanged: (dateTime) {
                                                print(dateTime);
                                                setState(() {
                                                  pickedtime_record =
                                                      "${dateTime.hour} : ${dateTime.minute} : ${dateTime.second}";
                                                  showNotificationsDaily(2,dateTime.hour, dateTime.minute);
                                                  addTimeRecordToSF(pickedtime_record);
                                                });
                                              },

                                            );
                                          }
                                        );
                                      },
                                    ) 
                                  ),
                                )
                              ]
                            ),
                          );
                      }),

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