import 'package:flutter/material.dart';
import 'package:savemoney/constant.dart';

import 'widget/goal_card.dart';

class DataTarget extends StatefulWidget {
  @override
  _DataTargetState createState() => _DataTargetState();

}

class _DataTargetState extends State<DataTarget>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Goals',style: kAppbar,),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.notifications),onPressed: (){},)
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
                                      Text(
                                        '0 Goals',
                                        style: TextStyle(
                                          fontSize: 30,
                                        )
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
                                            Text('0', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
                                            Text('New Item'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 16),)
                                          ]
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text('0', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
                                            Text('nearly'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 16),)
                                          ]
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text('0', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
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
                          Text(
                            "Progress",
                            style: TextStyle(
                              color: yellowLowColor,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline
                            ),
                          ),
                          SizedBox(width:5),
                          Text(
                            "Completed",
                            style: TextStyle(
                              color: kTextLightColor,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ]
                      ),
                      GoalCard(),
                  ]
                )
              ),
            ),
          ],
        ),
    );
  }
}