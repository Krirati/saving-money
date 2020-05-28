import 'package:flutter/material.dart';
import 'package:savemoney/tab_schedule/balance.dart';
import 'package:savemoney/tab_schedule/income.dart';
import 'package:savemoney/widget/remindercard.dart';

import 'constant.dart';
import 'tab_schedule/expenditure.dart';
import 'widget/dialog_notification.dart';

class History extends StatefulWidget {
  final Remin reminderItem;

  History({this.reminderItem});

  @override
  _HistoryState createState() => _HistoryState();

}

class _HistoryState extends State<History>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          
          title: Text('Schedule'),
          elevation: 0,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.notifications),
            onPressed: () async{
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return  DialogNotification();
                });
            },)
          ],
        ),
        backgroundColor: Colors.white,
        body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.orange[200],
            elevation: 0,
            flexibleSpace: TabBar(
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                tabs: [
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 2)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Balance"
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 2)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Income",
                         style: TextStyle(
                            fontSize: 24
                          ),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 2)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Expenditure",
                         style: TextStyle(
                            fontSize: 24
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                ]),
          ),
          body:  Stack(
            children: <Widget>[
              new Container(
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.orange[200], Colors.orange[200]]
                  ),
                ),
                height: 30,
              ),
              TabBarView(children: [
                BalanceScreen(),
                IncomeScreen(),
                ExpenditureScreen(),
              ])
            ],
            ),
          )

        )
      );  
  }
}