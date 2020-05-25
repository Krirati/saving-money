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
        new CircularSegmentEntry(500.0, Colors.red[200], rankKey: 'Q1'),
        new CircularSegmentEntry(1000.0, Colors.green[200], rankKey: 'Q2'),
        new CircularSegmentEntry(2000.0, Colors.yellow[200], rankKey: 'Q3'),
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
                                          color: Colors.red,
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
                                          color: Colors.red,
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
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 10,
                                          width: 10,
                                          color: Colors.red,
                                          margin: EdgeInsets.all(3),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                            ]
                                          ),
                                        ),
                                        Text('Arrears'),
                                      ]
                                    ),
                                  ],
                                )
                              ),
                            ],
                          ),
                          DataTable(
                            columnSpacing:80,
                            columns: [
                              DataColumn(label: Text('Type')),
                              DataColumn(label: Text('Price')),
                              DataColumn(label: Text('Percent')),
                            ], 
                            rows: [
                              DataRow(cells: [
                                DataCell(Text('Income')),
                                DataCell( FutureBuilder(
                                  future: loadSum('income'),
                                  builder: (BuildContext context, AsyncSnapshot<double>snapshot) {
                                      return Text('${snapshot.data}');
                                    }
                                  )
                                ),
                                DataCell(Text('10%')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('Expenditure')),
                                DataCell( FutureBuilder(
                                  future: loadSum('expenditure'),
                                  builder: (BuildContext context, AsyncSnapshot<double>snapshot) {
                                      return Text('${snapshot.data}');
                                    }
                                  )
                                ),
                                DataCell(Text('50%')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('Saving for goals')),
                                DataCell( FutureBuilder(
                                  future: loadSum('goals'),
                                  builder: (BuildContext context, AsyncSnapshot<double>snapshot) {
                                      return Text('${snapshot.data}');
                                    }
                                  )
                                ),
                                DataCell(Text('70%')),
                              ]),
                            ]
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