
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:savemoney/widget/datepicker.dart';
import 'package:savemoney/widget/field_select_type.dart';

import 'constant.dart';
import 'widget/dialog_notification.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
  }
  
class _AddEventState extends State<AddEvent>{
  var nameController = TextEditingController();
  var amountController = TextEditingController();
  var desciprionController = TextEditingController();

  String time = DateTime.now().toString();
  DateTime newDateTime;
  DateTime date = DateTime.now();

  File _image;

  callback(newTime) {
    setState(() {
      time = newTime;
      print('time:  ' + time);
    
    });
  }
  void initState() {
    super.initState();
    newDateTime = DateTime.now();
  } 
  clearField() {
    setState(() {
      nameController = null;
      amountController = null;
      desciprionController = null;
    });
  }

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('_image $_image');
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add New Activity'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios) ,
            onPressed: () {
              Navigator.pop(context);
            } 
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () async{
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return  DialogNotification();
                  });
              },)
          ],
          // elevation: 0,
        ),
        backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.save),
            backgroundColor: Colors.orangeAccent,
            label: Text('Save'),
            onPressed: (){
              setState(() {
                print('Save');
              },);
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body:
          ListView(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal:15 ),
            children: <Widget>[
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Name Event',
                                style: TextStyle(
                                    color: Colors.black
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: TextField(
                                  controller:  nameController,
                                  decoration: InputDecoration(
                                    hintText: 'Name',
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide()
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Type',
                                style: TextStyle(
                                    color: Colors.black
                                ),
                              ),
                              FieldType(),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Amount',
                                style: TextStyle(
                                    color: Colors.black
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: amountController,
                                  decoration: InputDecoration(
                                    hintText: 'Amount',
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Colors.white
                                      )
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[50],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Date & Time',
                                style: TextStyle(
                                    color: Colors.black
                                ),
                              ),
                              RaisedButton(
                                color: Colors.grey[100],
                                padding: EdgeInsets.all(10.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(color: Colors.grey)
                                ),
                                onPressed: ()
                                async{
                                  await showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DatePickerWidget(callback);
                                    }
                                  );
                                },
                                child: new Text(time),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Descirption',
                                style: TextStyle(
                                    color: Colors.black
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: '',
                                    contentPadding: EdgeInsets.all(10.0),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide()
                                    ),
                                  ),
                                  onChanged: null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  // Icon(
                                  //   Icons.image,
                                  //   color: kTextLightColor,),
                                  Text(
                                    'Pictures',
                                    style: TextStyle(
                                        color: Colors.black
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal:15),
                                child: GestureDetector(
                                  onTap: _getImage,
                                    child: Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300],
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0,1),
                                          )
                                        ]
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                _image == null ? Icon(Icons.image,color: kTextLightColor, size: 100,) : Image.file(_image,
                                                height: 120,
                                                fit: BoxFit.fill,),
                                              ],
                                            ),
                                          ],
                                        )                                       
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],          
          ) ,          
        ),
    );
  }
}
