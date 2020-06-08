import 'package:flutter/material.dart';
import 'package:savemoney/database/dbHelper.dart';
import 'package:savemoney/database/model.dart';

import '../constant.dart';


class DialogHistoryGoal extends StatefulWidget {
  final String name;

  const DialogHistoryGoal({this.name});
  @override
  _DialogHistoryGoalState createState() => _DialogHistoryGoalState();
}

class  _DialogHistoryGoalState  extends State<DialogHistoryGoal>{
  var dbHelper;
  Future<List<EventModel>> events;
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshList();
  }

  refreshList() {
    setState(() {
      events = dbHelper.getGoalsHis(widget.name);
    });
  }

    SingleChildScrollView dataTable(List<EventModel> events) {
    var singleChildScrollView = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children:<Widget>[
          for (var i = 0; i < events.length; i++) 
            CardHistory(
              id: events[i].id,
              name: events[i].name,
              time: events[i].date,
              amount: events[i].amount,
              icon: events[i].icon,
            )
        ]
      ) 
    );
    return singleChildScrollView;
  }
  list() {
    return Container(
      margin: EdgeInsets.symmetric(vertical:10),
      child: FutureBuilder(
        future: events,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
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
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ), 
      elevation: 2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:10, vertical:5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('History of ${widget.name}',
                    style: kHeadingTextStyle,),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.close, color: Colors.black, size: 30,),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }
                  ),
                ],
            ),
            list()
          ],
        )
      )
    );
  } 
}
class CardHistory extends StatefulWidget {
  final int id;
  final String name;
  final String time;
  final double amount;
  final String icon;
  const CardHistory({ this.id, this.name, this.time, this.amount, this.icon});
  _CardHistroryState createState() => _CardHistroryState();
}

class _CardHistroryState extends State<CardHistory> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('click');
      },
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.symmetric(vertical:5, horizontal:10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(widget.icon,width: 40, height: 40,),
              SizedBox(width:5),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${widget.name}\n',
                      style: kTitleTextstyle,
                    ),
                    TextSpan(
                      text: '${widget.time.split('.')[0]}',
                      style: TextStyle(
                        color: kTextLightColor
                      ),
                    ),
                  ]
                ),
              ),
              Spacer(),
              Text('${widget.amount}')
            ],
          )
        ),
      )
    );
  }

}