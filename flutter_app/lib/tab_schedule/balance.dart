import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

import '../constant.dart';

class BalanceScreen extends StatefulWidget {
  @override
  _BalanceScreenState createState() => _BalanceScreenState();

}

class _BalanceScreenState extends State<BalanceScreen> {
  
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();


  List<CircularStackEntry> data = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(500.0, Colors.red[200], rankKey: 'Q1'),
        new CircularSegmentEntry(1000.0, Colors.green[200], rankKey: 'Q2'),
        new CircularSegmentEntry(2000.0, Colors.blue[200], rankKey: 'Q3'),
        new CircularSegmentEntry(1000.0, Colors.yellow[200], rankKey: 'Q4'),
        new CircularSegmentEntry(1000.0, Colors.yellow, rankKey: 'Qถ'),
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
                                        Text('Balance'),
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
                                        Text('Expenditure'),
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
                                DataCell(Text('1000')),
                                DataCell(Text('10%')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('Expenditure')),
                                DataCell(Text('1000')),
                                DataCell(Text('50%')),
                              ]),
                              DataRow(cells: [
                                DataCell(Text('Balance')),
                                DataCell(Text('1000')),
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
              TypeResult()
            ],
          ),
        ]
      )
    ),
   );
  }
}

class TypeResult  extends StatefulWidget{
  @override
  _TypeResultState createState() => _TypeResultState();
  
}

class _TypeResultState extends State<TypeResult> {
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
                  Icon(
                    Icons.fastfood,
                    color: kTextLightColor,
                    size: 30,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    'Type',
                    style: kHeadingTextStyle,
                  )
                ],
              ),
              DataTable(
                columnSpacing:150,
                columns: [
                  DataColumn(label: Text('Type')),
                  DataColumn(label: Text('Price')),
                ], 
                rows: [
                  DataRow(cells: [
                    DataCell(Text('วันนี้')),
                    DataCell(Text('1000')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('เมื่อวาน')),
                    DataCell(Text('1000')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('สัปดาห์ล่าสุด')),
                    DataCell(Text('1000')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('เดือนล่าสุด')),
                    DataCell(Text('1000')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('ุ6 เดือนล่าสุด')),
                    DataCell(Text('1000')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('ุ12 เดือนล่าสุด')),
                    DataCell(Text('1000')),
                  ]),
                ]
              ),
            ]
          ),
        ),
      ),
    );
  }
  
}