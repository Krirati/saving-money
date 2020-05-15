import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savemoney/constant.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DialogNotification extends StatefulWidget {
  @override
  _DialogNotificationState createState() => _DialogNotificationState();
}

class _DialogNotificationState extends State<DialogNotification>{
  bool _notification = false;
  bool _saving = false;
  bool _record = false;
  var pickedtime_saving;
  var pickedtime_record;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                                        currentTime: DateTime.now(), onConfirm: (time) {
                                      setState(() {
                                        pickedtime_record =
                                            "${time.hour} : ${time.minute} : ${time.second}";
                                      });
                                    });
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
                                        currentTime: DateTime.now(), onConfirm: (time) {
                                      setState(() {
                                        pickedtime_record =
                                            "${time.hour} : ${time.minute} : ${time.second}";
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