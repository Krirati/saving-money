
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:savemoney/database/dbHelper.dart';
import 'package:savemoney/database/model.dart';
import 'package:savemoney/widget/datepicker.dart';
import 'package:savemoney/widget/field_select_type.dart';

import 'database/goalmodel.dart';


class AddEvent extends StatefulWidget {
  final int  id;
  final String name; 
  final double price; 
  final String time; 
  final String icon;
  final String description;
  final String type;
  final bool update;
  final Function(bool) callback;
  const AddEvent({this.id, this.name, this.price, this.time,this.type, this.icon, this.description, this.update, this.callback});
  @override
  _AddEventState createState() => _AddEventState();
  }
  
class _AddEventState extends State<AddEvent>{
  var nameController = TextEditingController();
  var amountController = TextEditingController();
  var desciprionController = TextEditingController();
  String name;
  String amount;
  String des;
  String type;
  String icon; 
  String time = DateTime.now().toString();
  DateTime newDateTime;
  int curUserId;

  // File _image;
  int updateNo;

  final formKeyName = new GlobalKey<FormState>();
  final formKeyAmount = new GlobalKey<FormState>();
  final formKeyDes = new GlobalKey<FormState>();
  final formKeyType = new GlobalKey<FormState>();
  final formKeyIcon = new GlobalKey<FormState>();
  final formKeyTime= new GlobalKey<FormState>();
  
  var dbHelper;
  bool isUpdating;
  Future<List<EventModel>> events;

  callback(newTime) {
    setState(() {
      time = newTime;
      print('time:  ' + time);
    });
  }
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    newDateTime = DateTime.now();
    isUpdating = false;

    if (widget.update != null) {
      isUpdating = widget.update;
      nameController.text = widget.name;
      amountController.text = widget.price.toString();
      desciprionController.text = widget.description;
      time = widget.time;
      icon = widget.icon;
      curUserId = widget.id;
      type = widget.type;
    }
  } 


  clearField() {
    setState(() {
      nameController.clear();
      amountController.clear();
      desciprionController.clear();
    });
  }

  validate() {
    if (formKeyName.currentState.validate()) {
      formKeyName.currentState.save();
      if(isUpdating) {
        EventModel e = EventModel(
          id: curUserId, 
          name: nameController.text, 
          type: type, 
          icon: icon, 
          amount: double.parse(amountController.text), 
          date: time,
          description: desciprionController.text);
        dbHelper.update(e);
        widget.callback(true);
        setState(() {
          isUpdating = false;
        });
        // Navigator.pop(context);
      } else {
        EventModel e = EventModel(
          name: nameController.text, 
          type: type, 
          icon: icon,
          amount: double.parse(amountController.text), 
          date: time, 
          description: desciprionController.text
        );
        if (type == 'goals') {
          GoalModel g = GoalModel(
            name: nameController.text,
            type: type,
            total: double.parse(amountController.text),
            current: 0.0,
            icon: icon,
            dateFinish: time,
            description: desciprionController.text,
            status: 'wait',
          );
          dbHelper.insertGoals(g);
        } 
        else {
          dbHelper.insert(e);
        }
      }
      dialogShow();
      clearField();
    }
  }
  // Future _getImage() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = image;
  //     print('_image $_image');
  //   });
  // }

  callbackResultIcon(newType, newIcon) {
    setState(() {
      type = newType;
      icon = newIcon;
    });
    print('add type: $type');
    print('add icon: $icon');
  }

  Future dialogShow() async {
    String msg;
    if (widget.update == true) {
      msg = 'Update';
    } else {
      msg = 'Insert';
    }
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
        });
        return Stack(
        children: <Widget>[
          SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            contentPadding: EdgeInsets.all(10),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assests/icon/tick.png', width: 80,height:80,)
                ]
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:5),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('$msg sucessful'),
                  ]
                ),
              ),
            ],
          ),

        ],
      );
      },

    );
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height ;
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.save),
          backgroundColor: Colors.orangeAccent,
          label: Text(isUpdating ? 'Update': 'Save'),
          onPressed: () async{
            print('save ...');
            validate();
            print('save done');
            clearField();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: null,
                image: DecorationImage(
                  // alignment: Alignment.centerLeft,
                  image: AssetImage('assests/images/Group1.png'),
                  fit: BoxFit.cover
                )
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Add new event'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                          ),
                        ),

                      ]
                    ),
                  ),

                ],
              ),
            ),       
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
                  child: ListView(
                    children: <Widget>[
          
                      Container(
                        // padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Form(
                                  key: formKeyName,
                                  child: Container(
                                    margin: EdgeInsets.all(12),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Name Event',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: width*0.045,
                                          ),
                                        ),
                                        Container(
                                          // margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                          margin: EdgeInsets.only(top:5),
                                          color: Colors.white,
                                          child: TextFormField(
                                            controller: nameController,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              hintText: 'Name',
                                              contentPadding: EdgeInsets.all(10.0),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  color: Colors.red
                                                )
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                            validator: (val) => val.length == 0 ? 'Enter Name' : null,
                                            onSaved: (val) => name = val,                                    
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              
                                
                                Form(
                                  key: formKeyType,
                                  child: Container(
                                  margin: EdgeInsets.all(12),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Type',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: width*0.045,
                                        ),
                                      ),
                                      FieldType(callbackResultIcon),
                                    ],
                                  ),
                                  ),
                                ),
                                Form(
                                  key: formKeyAmount,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          (type == 'goals') ? 'Target amount':'Amount',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: width*0.045,
                                          ),
                                        ),
                                        Container(
                                          // margin: EdgeInsets.all(10),
                                          margin: EdgeInsets.only(top:5),
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
                                              fillColor: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text(
                                        (type == 'goals') ? 'Target date':'Date & Time',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: width*0.045,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal:0),
                                        child: RaisedButton(
                                          color: Colors.grey[50],
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
                                          child: new Text('TIME: ' + time),
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
                                      Text(
                                        'Descirption',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: width*0.045,
                                        ),
                                      ),
                                      Container(
                                        // margin: EdgeInsets.all(10),
                                        
                                        child: TextField(
                                          key: formKeyDes,
                                          controller: desciprionController,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 3,
                                          decoration: InputDecoration(
                                            hintText: '',
                                            contentPadding: EdgeInsets.all(10.0),
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                              )
                                            ),
                                          ),
                                          onChanged: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                                //   child: Column(
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: <Widget>[
                                //       Row(
                                //         mainAxisAlignment: MainAxisAlignment.start,
                                //         children: <Widget>[
                                //           Text(
                                //             'Pictures',
                                //             style: TextStyle(
                                //                 color: Colors.black,
                                //                 fontWeight: FontWeight.w600
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //       SizedBox(height: 12,),
                                //       Padding(
                                //         padding: EdgeInsets.symmetric(horizontal:15),
                                //         child: GestureDetector(
                                //           onTap: _getImage,
                                //             child: Container(
                                //             height: 120,
                                //             decoration: BoxDecoration(
                                //                 color: Colors.white70,
                                //                 borderRadius: BorderRadius.circular(8),
                                //                 boxShadow: [
                                //                   BoxShadow(
                                //                     color: Colors.grey[300],
                                //                     spreadRadius: 1,
                                //                     blurRadius: 3,
                                //                     offset: Offset(0,1),
                                //                   )
                                //                 ]
                                //             ),
                                //             child: Column(
                                //               crossAxisAlignment: CrossAxisAlignment.start,
                                //               children: <Widget>[
                                //                 Column(
                                //                   crossAxisAlignment: CrossAxisAlignment.start,
                                //                   children: <Widget>[
                                //                     Row(
                                //                       mainAxisAlignment: MainAxisAlignment.center,
                                //                       children: <Widget>[
                                //                         _image == null ? Icon(Icons.image,color: kTextLightColor, size: 100,) : Image.file(_image,
                                //                         height: 120,
                                //                         fit: BoxFit.fill,),
                                //                       ],
                                //                     ),
                                //                   ],
                                //                 )                                       
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],          
                ) ,
              ),
            ),
          ]
        )

             
    );
  }
}
