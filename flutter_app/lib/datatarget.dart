import 'package:flutter/material.dart';
import 'package:savemoney/constant.dart';

import 'database/dbHelper.dart';
import 'database/goalmodel.dart';
import 'widget/dialog_notification.dart';
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
  }
  void refreshListGoal() {
    setState(() {
      if (progress) {
        events = dbHelper.getGoals();
      } else {
        events = dbHelper.getGoalsCom();  
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
            return Text('No Goal Found');
          }
          return CircularProgressIndicator();
        },
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Goals',style: kAppbar,),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.notifications),
              onPressed: () async{
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return  DialogNotification();
                  }
                );
              },
            )
          ],
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.orange[200], Colors.orange[200]]
                ),
              ),
              height: 85,
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical:10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        ),
                        elevation: 4,
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
                      SizedBox(height: 20,),
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
                      list()
                  ]
                )
              ),
            ),
          ],
        ),
    );
  }
}