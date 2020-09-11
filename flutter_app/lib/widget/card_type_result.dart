

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savemoney/database/dbHelper.dart';

import '../constant.dart';

class CardTypeResult extends StatefulWidget{
  final String icon;

  CardTypeResult({this.icon});
  @override
  _CardTypeResultState createState()  => _CardTypeResultState();

}

class _CardTypeResultState extends State<CardTypeResult> {
  var dbHelper = DBHelper();
  // int _total;
  Future<List> day;
  Future<List> month;
  Future<List> year;
  @override
  initState(){
    super.initState();
    loadSum(widget.icon);
    day = dbHelper.sumType(widget.icon);
    month = dbHelper.sumType(widget.icon);
    year = dbHelper.sumType(widget.icon);
  }

  Future loadSum(type) async {
    var result = await dbHelper.sumType(type);
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 1,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(widget.icon, height: 40, width: 40,),
                  SizedBox(width: 10,),
                  Text(
                    '${widget.icon.split('/')[2].split('.')[0]}',
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
                      FutureBuilder(
                        future: loadSum(widget.icon),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              '${snapshot.data[0]['Total']} Bath',
                              style: TextStyle(
                                fontSize: 24,
                            ));
                          }
                          if(null == snapshot.data || snapshot.data.length == 0){
                            return Text('0 Bath',
                              style: TextStyle(
                                fontSize: 24,
                            ));
                          }
                          return CircularProgressIndicator();
                          
                          
                        }
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
                            FutureBuilder(
                              future: day,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    '${snapshot.data[0]['Total']}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w200
                                  ));
                                }
                                if(null == snapshot.data || snapshot.data.length == 0){
                                  return Text('0',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w200
                                  ));
                                }
                                return CircularProgressIndicator();
                                
                                
                              }
                            ),
                            Text('today'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 14),)
                          ]
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FutureBuilder(
                              future: month,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    '${snapshot.data[0]['Total']}',
                                    style: TextStyle(
                                      fontSize: 18,
                                  ));
                                }
                                if(null == snapshot.data || snapshot.data.length == 0){
                                  return Text('0',
                                    style: TextStyle(
                                      fontSize: 18,
                                  ));
                                }
                                return CircularProgressIndicator();
                                
                                
                              }
                            ),
                            Text('month'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 14),)
                          ]
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FutureBuilder(
                              future: year,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    '${snapshot.data[0]['Total']}',
                                    style: TextStyle(
                                      fontSize: 18,
                                  ));
                                }
                                if(null == snapshot.data || snapshot.data.length == 0){
                                  return Text('0',
                                    style: TextStyle(
                                      fontSize: 18,
                                  ));
                                }
                                return CircularProgressIndicator();
                                
                                
                              }
                            ),
                            Text('year'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 14),)
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