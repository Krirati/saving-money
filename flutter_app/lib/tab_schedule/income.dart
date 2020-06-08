import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:savemoney/database/dbHelper.dart';
import 'package:savemoney/database/model.dart';
import 'package:savemoney/widget/card_event.dart';


class IncomeScreen  extends StatefulWidget{

  @override
 _IncomeScreenState createState() => _IncomeScreenState();

}


class _IncomeScreenState extends State<IncomeScreen> {
  GlobalKey actionKey;
  String dropdownValue;
  Future<List<EventModel>> events;
  int numCount;

  var dbHelper;
  @override
  void initState() {
    actionKey = LabeledGlobalKey('mode');
    super.initState();
    dbHelper = DBHelper();
    refreshList();
  }

  refreshList() {
    setState(() {
      events = dbHelper.quertTypeEvent('income','');
      
    });
  }
  callback(update) {
    if(update == true) {
      refreshList();
    }
  }
  SingleChildScrollView dataTable(List<EventModel> events) {
    var singleChildScrollView = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children:<Widget>[
          for (var i = 0; i < events.length; i++) 
            CardEvent(
              id: events[i].id,
              name: events[i].name, 
              price: events[i].amount, 
              time: events[i].date,
              type: events[i].type, 
              icon: events[i].icon,
              description: events[i].description,
              callback: callback,
            ),
        ]
      ) 
    );
    return singleChildScrollView;
  }
  list() {
    return Container(
      // margin: EdgeInsets.symmetric(vertical:10),
            child: FutureBuilder(
        future: events,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.length != 0) {
            return dataTable(snapshot.data);
          }
          if(null == snapshot.data || snapshot.data.length == 0){
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height:30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 170,
                        width: 170,
                        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assests/icon/box.png'))
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Not have income.')
     
                ],)
            );
          }
          return CircularProgressIndicator();
        },
      
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return 
      ListView(
      padding: EdgeInsets.symmetric(vertical:5, horizontal: 15),
      addAutomaticKeepAlives: true,
      children: <Widget>[
//                Container(
//                  padding:
//                    EdgeInsets.symmetric(horizontal: 16, vertical: 5),
//                  alignment: Alignment.centerRight,
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.circular(10),
//                    boxShadow:  [
//                      BoxShadow(
//                        color: Colors.grey.withOpacity(0.5),
//                        spreadRadius: 1,
//                        blurRadius:4,
//                        offset: Offset(0,3),
//                      )
//                    ]
//                  ),
//
//                  // dropdown below..
//                  child: Row(
//                    children: <Widget>[
//                      Text('Select Rang'.toUpperCase(), style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w300)),
//                      Spacer(),
//                      DropdownButton<String>(
//                        dropdownColor: Colors.white,
//                        value: dropdownValue,
//                        focusColor: Colors.red,
//                        icon: Icon(Icons.arrow_drop_down, color: Colors.black,),
//                        iconSize: 42,
//                        underline: SizedBox(),
//                        onChanged: (String newValue) {
//                          setState(() {
//                            dropdownValue = newValue;
//                            print(dropdownValue);
//                          });
//                        },
//                        hint: Text('select'.toUpperCase()),
//                        items: <String>[
//                          'Day',
//                          'Week',
//                          'Month',
//                          'Year'
//                        ].map<DropdownMenuItem<String>>((String value) {
//                          return DropdownMenuItem<String>(
//                            value: value,
//                            child: Text(value , style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600)),
//                          );
//                        }).toList()
//                      ),
//                    ],
//                  )
//                ),
                // SizedBox(height: 5),
                list()
                
              ],
            
    );
  } 
}