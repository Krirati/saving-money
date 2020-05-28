import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:savemoney/database/dbHelper.dart';
import 'package:savemoney/widget/card_type_result.dart';

import '../constant.dart';

class BalanceScreen extends StatefulWidget {
  @override
  _BalanceScreenState createState() => _BalanceScreenState();

}

class _BalanceScreenState extends State<BalanceScreen> {
  
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
  var dbHelper = DBHelper();

  Future<double> loadSum(name) async {
    var result = dbHelper.sumAll(name);
    return result;
  }
  Future<double> loadBalance() async {
    var result = dbHelper.balance();
    return result;
  }

  List<CircularStackEntry> data = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(500.0, incomeColor, rankKey: 'Q1'),
        new CircularSegmentEntry(1000.0, expenditureColor, rankKey: 'Q2'),
        new CircularSegmentEntry(2000.0, Colors.blue[100], rankKey: 'Q3'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];
  

  @override
  Widget build(BuildContext context) {
   return SafeArea(
    child: Scaffold(
      body: ListView(
        // shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical:1, horizontal: 15),
        addAutomaticKeepAlives: true,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Container(
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
                              Icon(
                                Icons.list,
                                color: kTextLightColor,
                                size: 30,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                'Total',
                                style: kHeadingTextStyle,
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: new AnimatedCircularChart(
                                  key: _chartKey,
                                  size: const Size(250.0, 250.0),
                                  initialChartData: data,
                                  chartType: CircularChartType.Pie,
                                  // percentageValues: true,
                                ),
                              ),     
                              Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 10,
                                          width: 10,
                                          color: incomeColor,
                                          margin: EdgeInsets.all(3),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                            ]
                                          ),
                                        ),
                                        Text('Income'),
                                      ]
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 10,
                                          width: 10,
                                          color: expenditureColor,
                                          margin: EdgeInsets.all(3),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                            ]
                                          ),
                                        ),
                                        Text('Expenditure'),
                                      ]
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 10,
                                          width: 10,
                                          color: Colors.blue[100],
                                          margin: EdgeInsets.all(3),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                            ]
                                          ),
                                        ),
                                        Text('Saving'),
                                      ]
                                    ),
                                  ],
                                )
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Divider(thickness: 1,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text('0', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
                                        Text('Income'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 16),)
                                      ]
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text('0', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
                                        Text('Expenditure'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 16),)
                                      ]
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text('0', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
                                        Text('Saving'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 16),)
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
                ),
              ),
              CardTypeResult()
            ],
          ),
        ]
      )
    ),
   );
  }  
}