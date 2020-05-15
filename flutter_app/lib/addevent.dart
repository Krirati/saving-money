
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:savemoney/widget/datepicker.dart';
import 'package:savemoney/widget/field_select_type.dart';

import 'constant.dart';

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
                decoration: BoxDecoration(
                  // color: Colors.white,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(20),
                  //   topRight: Radius.circular(20),
                  // ),
                ),
                padding: EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios) ,
                                onPressed: () {
                                  Navigator.pop(context);
                                } ),
                              // Spacer(),
                              Text(
                                'Add New Activity',
                                style: kTitleTextstyle,
                              ),
    
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          margin: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Name Event',
                                style: TextStyle(
                                    color: kTextLightColor
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(15),
                                child: TextField(
                                  controller:  nameController,
                                  decoration: InputDecoration(
                                    hintText: '',
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                  ),
                                ),
                              ),
                              Text(
                                'Type',
                                style: TextStyle(
                                    color: kTextLightColor
                                ),
                              ),
                            ],
                          ),
                        ),
                        FieldType(),
                        Container(
                          margin: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Amount',
                                style: TextStyle(
                                    color: kTextLightColor
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(15),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: amountController,
                                  decoration: InputDecoration(
                                    hintText: '',
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                  ),
                                ),
                              ),
                              Text(
                                'Date & Time',
                                style: TextStyle(
                                    color: kTextLightColor
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // margin: EdgeInsets.all(12),
                          margin: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              RaisedButton(
                                color: Colors.grey[200],
                                padding: EdgeInsets.all(10.0),
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
                          margin: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Descirption',
                                style: TextStyle(
                                    color: kTextLightColor
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(15),
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: '',
                                    contentPadding: EdgeInsets.all(10.0),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                  ),
                                  onChanged: null,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.image,
                                    color: kTextLightColor,),
                                  Text(
                                    'Pictures',
                                    style: TextStyle(
                                        color: kTextLightColor
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                // margin: EdgeInsets.all(15),
                                child: GestureDetector(
                                  onTap: _getImage,
                                    child: Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0,1),
                                          )
                                        ]
                                    ),
                                    // margin: EdgeInsets.symmetric(horizontal: 45),
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
