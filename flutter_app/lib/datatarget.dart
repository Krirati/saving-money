import 'package:flutter/material.dart';
import 'package:savemoney/constant.dart';

import 'database/dbHelper.dart';
import 'database/goalmodel.dart';
import 'widget/datepicker.dart';
import 'widget/dialog_notification.dart';
import 'widget/field_select_goal.dart';
import 'widget/goal_card.dart';

class DataTarget extends StatefulWidget {
  @override
  _DataTargetState createState() => _DataTargetState();

}

class _DataTargetState extends State<DataTarget>{

  Future<List<GoalModel>> events;
  Future<int> countGoal;
  Future<int> countGoalNew;
  Future<int> countGoalCom;
  Future<int> countGoalNear;
  var dbHelper;
  bool progress = true;
  String msg;
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshList();
    callback(true);
  }

  void refreshList() {
    setState(() {
      events = dbHelper.getGoals();
      countGoal = dbHelper.countGoal();
      countGoalCom = dbHelper.countGoalCompleted();
      countGoalNew = dbHelper.countGoalNew();
      countGoalNear = dbHelper.countGoalNear();
    });
  }
  callback(update) {
    if (update == true) {
      refreshList();
      progress = true;
    }
    refreshList();
  }
  void refreshListGoal() {
    setState(() {
      if (progress) {
        events = dbHelper.getGoals();
        msg = '';
      } else {
        events = dbHelper.getGoalsCom();  
        msg = ' completed';
      }
    });
  }
  SingleChildScrollView dataTable(List<GoalModel> events) {
    var singleChildScrollView = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children:<Widget>[
          for (var i = 0; i < events.length; i++) 
            GoalCard(
              id: events[i].id, 
              name: events[i].name, 
              totalMoney: events[i].total,
              current: events[i].current, 
              dateEnd: events[i].dateFinish, 
              icon: events[i].icon,
              type: events[i].type,
              description: events[i].description,
              callback: callback,)
        ]
      ) 
    );
    return singleChildScrollView;
  }
  list() {
    return Expanded(
      child: FutureBuilder(
        future: events,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.length != 0) {
            return dataTable(snapshot.data);
          }
          if(null == snapshot.data || snapshot.data.length == 0){
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 170,
                        width: 170,
                        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assests/icon/box.png'))
                        ),
                      ),
                      SizedBox(width: 10),
                      Text('Not have goal$msg.')
                    ],
                  ),
     
                ],)
            );
          }
          return CircularProgressIndicator();
        },
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          backgroundColor: Colors.orangeAccent,
          label: Text('Add'),
          onPressed: () async{
            await showDialog(
              context: context,
              builder: (BuildContext context) {
            
                return  GoalAdd(callBack: callback);
              }
            ); 
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
                  image: AssetImage('assests/images/page2.png'),
                  fit: BoxFit.cover
                )
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Goals'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.notifications, color: Colors.black, size: 30,) , 
                          onPressed: () async{
                            print("notification");
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                            
                                return  DialogNotification();
                              });
                          }
                        )
                      ],
                    ),
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      elevation: 1,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        height: 180,
                          child: Column(
                            children:<Widget>[
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FutureBuilder(
                                    future: countGoal,
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData) {
                                        return Text(
                                          '${snapshot.data} Goals',
                                          style: TextStyle(
                                            fontSize: 30,
                                          )
                                        );
                                      }
                                      if(null == snapshot.data || snapshot.data.length == 0) {
                                        return Text('0 Goals',
                                          style: TextStyle(
                                            fontSize: 30,
                                          )
                                        );
                                      }
                                      return CircularProgressIndicator();
                                    }
                                  ),
                                  
                
                                ],
                              ),
                              SizedBox(height: 25,), 
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        FutureBuilder(
                                          future: countGoalNew,
                                          builder: (context, snapshot) {
                                            if(snapshot.hasData) {
                                              return Text(
                                                '${snapshot.data}',
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w500
                                                )
                                              );
                                            }
                                            if(null == snapshot.data || snapshot.data.length == 0) {
                                              return Text('0',
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w500
                                                )
                                              );
                                            }
                                            return CircularProgressIndicator();
                                          }
                                        ),
                                        // Text('0', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
                                        Text('New Item'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 16),)
                                      ]
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        FutureBuilder(
                                          future: countGoalNear,
                                          builder: (context, snapshot) {
                                            if(snapshot.hasData) {
                                              return Text(
                                                '${snapshot.data}',
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w500
                                                )
                                              );
                                            }
                                            if(null == snapshot.data || snapshot.data.length == 0) {
                                              return Text('0',
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w500
                                                )
                                              );
                                            }
                                            return CircularProgressIndicator();
                                          }
                                        ),                                            
                                        // Text('0', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
                                        Text('nearly'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 16),)
                                      ]
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        FutureBuilder(
                                          future: countGoalCom,
                                          builder: (context, snapshot) {
                                            if(snapshot.hasData) {
                                              return Text(
                                                '${snapshot.data}',
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w500
                                                )
                                              );
                                            }
                                            if(null == snapshot.data || snapshot.data.length == 0) {
                                              return Text('0',
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w500
                                                )
                                              );
                                            }
                                            return CircularProgressIndicator();
                                          }
                                        ),
                                        // Text('0', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
                                        Text('Completed'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 16),)
                                      ]
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          ),
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Goals lists',
                          style: TextStyle(
                            fontSize: 17
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              progress = true;
                              refreshListGoal();
                            });
                          },
                          child: Text(
                            "Progress",
                            style: TextStyle(
                              color: (progress) ? yellowLowColor: kTextLightColor,
                              fontWeight: FontWeight.w400,
                              decoration: (progress) ?TextDecoration.underline :TextDecoration.none
                            ),
                          ),
                        ),

                        SizedBox(width:5),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              progress = false;
                              refreshListGoal();
                            });
                          },
                          child: Text(
                            "Completed",
                            style: TextStyle(
                              color: (progress) ? kTextLightColor : yellowLowColor,
                              fontWeight: FontWeight.w400,
                              decoration: (progress) ?TextDecoration.none :TextDecoration.underline
                            ),
                          ),
                        ),
                      ]
                    ),
                    list(),
                    // SizedBox(height:20)
                  ]
                ),
              ),
            ),
          ],
        ),
    );
  }
}

class GoalAdd extends StatefulWidget {
  final Function(bool) callBack;
  final int  id;
  final String name; 
  final double price; 
  final String time; 
  final String icon;
  final String description;
  final String type;
  final bool update;
  const GoalAdd({ this.callBack, this.id, this.name, this.price, this.time, this.icon, this.description, this.type, this.update});
  @override
  _GoalAddState createState() => _GoalAddState();
}

class _GoalAddState extends State<GoalAdd> {

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


  int updateNo;

  final formKeyName = new GlobalKey<FormState>();
  final formKeyAmount = new GlobalKey<FormState>();
  final formKeyDes = new GlobalKey<FormState>();
  final formKeyType = new GlobalKey<FormState>();
  final formKeyIcon = new GlobalKey<FormState>();
  final formKeyTime= new GlobalKey<FormState>();
  
  var dbHelper;
  bool isUpdating;
  Future<List<GoalModel>> events;
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
  callbackTime(newTime) {
    setState(() {
      time = newTime;
      print('time:  ' + time);
    });
  }
  callbackResultIcon(newType, newIcon) {
    setState(() {
      type = newType;
      icon = newIcon;
    });
    print('add type: $type');
    print('add icon: $icon');
  }
  validate() {
    if (formKeyName.currentState.validate()) {
      formKeyName.currentState.save();
      if(isUpdating) {
        // GoalModel g = GoalModel(
        //     name: nameController.text,
        //     type: type,
        //     total: double.parse(amountController.text),
        //     current: 0.0,
        //     icon: icon,
        //     dateFinish: time,
        //     description: '',
        //     status: 'wait',
        //   );
      } else {
          GoalModel g = GoalModel(
            name: nameController.text,
            type: 'goals',
            total: double.parse(amountController.text),
            current: 0.0,
            icon: icon,
            dateFinish: time,
            description: '',
            status: 'wait',
          );
          dbHelper.insertGoals(g);
      }
      dialogShow();
      clearField();
    }
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
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ), 
      elevation: 2,
      child: Wrap(
        children: <Widget>[
          Stack(
            children: <Widget> [
              SafeArea(
                minimum: EdgeInsets.symmetric(vertical: 15, horizontal:10 ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Add new goal',
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
                    Form(
                      key: formKeyName,
                      child: Container(
                        margin: EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Name Goal',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600
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
                    FieldTypeGoal(callbackResultIcon),
                    Form(
                      key: formKeyAmount,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Target amount',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600
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
                            Container(
                              // margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(
                                   'Target date',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600
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
                                            return DatePickerWidget(callbackTime);
                                          }
                                        );
                                      },
                                      child: new Text('TIME: ' + time),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top:10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget> [
                                  FloatingActionButton.extended(
                                    icon: Icon(Icons.save),
                                    backgroundColor: Colors.orangeAccent,
                                    label: Text('Save'),
                                    onPressed: () async{
                                      validate();
                                      widget.callBack(true);
                                    },
                                  ),
                                ]
                              ),
                            )


                            
                          ],
                        ),
                      ),
                    ),
                  ]
                )
              )
            ]
          )
        ],
      )
    );
  }

}