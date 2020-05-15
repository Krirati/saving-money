import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {

  Function(String) callback;

  DatePickerWidget(this.callback);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();

}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime _dateTime = DateTime.now();

  void _sendDataBack(BuildContext context) {
    DateTime textToSendBack = _dateTime;
    Navigator.pop(context, textToSendBack);
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.dateAndTime,
      initialDateTime: _dateTime,
      backgroundColor: Colors.white,
      onDateTimeChanged: (dateTime) {
        print(dateTime);
        setState(() {
          _dateTime = dateTime;
          widget.callback(_dateTime.toString());
//          _sendDataBack(context);
        });
      },

    );
  }

}