

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class CardTypeResult extends StatefulWidget{
  @override
  _CardTypeResultState createState()  => _CardTypeResultState();

}

class _CardTypeResultState extends State<CardTypeResult> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset('assests/icon/revenue.png', height: 40, width: 40,),
                  SizedBox(width: 10,),
                  Text(
                    'Type',
                    style: kHeadingTextStyle,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '0 Bath',
                        style: TextStyle(
                          fontSize: 40,
                        )
                      ),
                    ],
                  ),
                  SizedBox(height: 5,), 
                  Divider(thickness: 1,color: Colors.orange[200],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('0', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 35)),
                            Text('today'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 20),)
                          ]
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('0', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 35)),
                            Text('week'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 20),)
                          ]
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('0', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 35)),
                            Text('month'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 20),)
                          ]
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('0', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 35)),
                            Text('year'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 20),)
                          ]
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]
          ),
        ),
      ),
    );
  
  }
}