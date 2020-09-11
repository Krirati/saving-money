import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
  
  var dbHelper = DBHelper();
  double income;
  double expenditure;
  double saving;

  void initState() {
    super.initState();
    dbHelper = DBHelper();

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
                          Chart(),
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
                                      Text(
                                        'Income',
                                      ),
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
                                      Text('Expend'),
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
                                        return Text(snapshot.data.toString(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18));
                                      }
                                    ), 
                                    Text('Income'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 14),)
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
                                        return Text(snapshot.data.toString(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18));
                                      }
                                    ), 
                                    Text('Expenditure'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 14),)
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
                                        return Text(snapshot.data.toString(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18));
                                      }
                                    ), 
                                    Text('Saving'.toUpperCase(), style: TextStyle(color: kTextLightColor, fontSize: 14),)
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
  double income;
  double expenditure;
  double saving;
  Future<double> loadSum(name) async {
    double result = await dbHelper.sumAll(name);
    print("result $name ${result.runtimeType}");
    setState(() {
      if(name == "income") {
        income = result;
        print(income);
      } else {
        expenditure = result;
        print(expenditure);
      }
    });
    return result;
  }
  Future<double> loadGoal() async {
    double result = await dbHelper.sumGoal();
    print("result goal $result");
    setState(() {
      saving = result;
      print(saving);
    });
    return result;
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    print("income $income");
    print("expenditure $expenditure");
    print("saving $saving");
    loadSum("income");
    loadSum("expenditure");
    loadGoal();

  }

  renderChart() {
    if(income == 0 && expenditure == 0 && saving == 0) {
      setState(() {
        income = 10;
        expenditure = 10;
        saving =10;
      });
    }
    PieChartSectionData _item1 =  PieChartSectionData(
        color: incomeColor,
        value: income,
        title: "",
        radius: 100,
    );
    PieChartSectionData _item2 = PieChartSectionData(
        color: expenditureColor,
        value: expenditure,
        title: "",
        radius: 100,
    );
    PieChartSectionData _item3 = PieChartSectionData(
        color: Colors.blue[100],
        value: saving,
        title: "",
        radius: 100,
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
        FutureBuilder(
            future: renderChart(),
            builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
              return PieChart(
                  PieChartData(
                      sections: _sections,
                      borderData: FlBorderData(
                          show: false,
                          border: null),
                      centerSpaceRadius: 10,
                      sectionsSpace: 0
                  )
              );
            }
        ),

      ],
      
    );
  }
}