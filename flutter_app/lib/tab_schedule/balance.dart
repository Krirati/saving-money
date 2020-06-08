import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:savemoney/database/dbHelper.dart';
import 'package:savemoney/database/model.dart';
import 'package:savemoney/widget/card_type_result.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constant.dart';

class BalanceScreen extends StatefulWidget {
  @override
  _BalanceScreenState createState() => _BalanceScreenState();

}

class _BalanceScreenState extends State<BalanceScreen> {
  
  // final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
  var dbHelper = DBHelper();
  double income = 0.0;
  double expenditure;
  double saving;

  void initState() {
    super.initState();
    dbHelper = DBHelper();
    income = 0.0;
    expenditure = 0.0;
    saving = 0.0;
  }
  Future<double> loadSum(name) async {
    var result = dbHelper.sumAll(name);
    return result;
  }
  Future<double> loadBalance() async {
    var result = dbHelper.balance();
    return result;
  }
  Future<List<EventModel>> loadGroupType() async {
    var result = dbHelper.getGroupType();
    return result;
  }
  Future<double> loadGoal() async {
    var result = dbHelper.sumGoal();
    return result;
  }

  SingleChildScrollView cardType(List<EventModel> events) {
    var singleChildScrollView = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children:<Widget>[
          for (var i = 0; i < events.length; i++) 
            CardTypeResult(
              icon: events[i].icon
            )
        ]
      ) 
    );
    return singleChildScrollView;
  }
  list() {
    return Container(
      child: FutureBuilder(
        future: loadGroupType(),
        builder: (context, snapshot) {
           if (snapshot.hasData) {
            return cardType(snapshot.data);
          }
          if(null == snapshot.data || snapshot.data.length == 0){
            return Text('No Data Found');
          }
          return CircularProgressIndicator();
        },
      )
    );
  }

  var intr= 0;
  List<CircularStackEntry> data = <CircularStackEntry>[
    CircularStackEntry(
      <CircularSegmentEntry>[
        CircularSegmentEntry(10, incomeColor, rankKey: 'Q1'),
        CircularSegmentEntry(10, expenditureColor, rankKey: 'Q2'),
        CircularSegmentEntry(10, Colors.blue[100], rankKey: 'Q3'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];
  

  @override
  Widget build(BuildContext context) {
   return ListView(
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
                elevation: 1,
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
                      Stack(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // Center(
                          //   child: new AnimatedCircularChart(
                          //     key: _chartKey,
                          //     size: Size(160.0, 160.0),
                          //     initialChartData: data,
                          //     chartType: CircularChartType.Pie,
                          //   ),
                          // ),
                          // Chart(),
                          Positioned(
                              right: 0,
                              child: Center(
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
                          ),
                          SizedBox(width: 10),
            
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
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
                                      future: loadSum('income'),
                                      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                                        return Text(snapshot.data.toString(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25));
                                      }
                                    ), 
                                    Text('Income'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 16),)
                                  ]
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    FutureBuilder(
                                      future: loadSum('expenditure'),
                                      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                                        return Text(snapshot.data.toString(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25));
                                      }
                                    ), 
                                    Text('Expenditure'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 16),)
                                  ]
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    FutureBuilder(
                                      future: loadGoal(),
                                      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                                        return Text(snapshot.data.toString(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25));
                                      }
                                    ), 
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
          list()
        ],
      ),
    ]
   );
  }  
}

class Chart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChartState();
  }
}
class _ChartState extends State<Chart> {
  List<PieChartSectionData> _sections = List<PieChartSectionData>();
  var dbHelper = DBHelper();
  double income = 0.0;
  double expenditure;
  double saving;
  Future<double> loadSum(name) async {
    var result = dbHelper.sumAll(name);
    return result;
  }
  Future<double> loadGoal() async {
    var result = dbHelper.sumGoal();
    return result;
  }
  
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    income = 0.0;
    expenditure = 0.0;
    saving = 0.0;
    FutureBuilder(
      future: loadSum('income'),
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        setState(() {
          income = snapshot.data;
        });
        return Text(snapshot.data.toString(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25));
      }
    );
    FutureBuilder(
      future: loadSum('expenditure'),
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        setState(() {
          expenditure = snapshot.data;
        });
        return Text(snapshot.data.toString(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25));
      }
    );
    FutureBuilder(
      future: loadGoal(),
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        setState(() {
          saving = snapshot.data;
        });
        return Text(snapshot.data.toString(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25));
      }
    ); 
    PieChartSectionData _item1 = PieChartSectionData(
      color: incomeColor, 
      value: income, 
      title: 'Income',
      radius: 100,
      titleStyle:  TextStyle(
        color: Colors.white,
        fontSize: 16
      )
    );
    PieChartSectionData _item2 = PieChartSectionData(
      color: expenditureColor, 
      value: expenditure, 
      title: 'Expenditure',
      radius: 100,
      titleStyle:  TextStyle(
        color: Colors.white,
        fontSize: 16
      )
    );
    PieChartSectionData _item3 = PieChartSectionData(
      color: Colors.blue[100], 
      value: 10, 
      title: 'Saving',
      radius: 100,
      titleStyle:  TextStyle(
        color: Colors.white,
        fontSize: 16
      )
    );
    _sections = [_item1, _item2, _item3];
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      // child: AspectRatio(
      //   aspectRatio: 1,
      children: <Widget>[
        PieChart(
          PieChartData(
            sections: _sections,
            borderData: FlBorderData(
              show: false,
              border: null),
            centerSpaceRadius: 10,
            sectionsSpace: 0
          )
        )
      ],
      
    );
  }
}