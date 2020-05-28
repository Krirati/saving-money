import 'package:flutter/material.dart';
import 'package:savemoney/database/dbHelper.dart';
import 'package:savemoney/datatarget.dart';

import '../constant.dart';

class GoalCard extends StatefulWidget{
  final int id;
  final String name;
  final String dateEnd;
  final double totalMoney;
  final double current;
  final String icon;
  Function(bool) callBack;

  GoalCard({this.id, this.name, this.current,this.dateEnd,this.totalMoney, this.icon, this.callBack});
  @override
  _GoalCardState createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard> {
  String dropdownValue;
  var dbHelper = DBHelper();
  int _money = 0;
  void add(){
    setState(() {
      _money++;
    });
  }
  void minus() {
    setState(() {
      if (_money != 0) 
        _money--;
    });
  }
  Future _dialogUpdate() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      child: Stack(
        children: <Widget>[
          SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            contentPadding: EdgeInsets.all(8),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(widget.icon, width: 80,height:80,)
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: add,
                    child: new Icon(Icons.add, color: Colors.black,),
                    backgroundColor: Colors.greenAccent,
                  ),
                  Text('$_money',
                      style: new TextStyle(fontSize: 60.0)),

                  FloatingActionButton(
                    onPressed: minus,
                    child: new Icon(
                    const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                      color: Colors.black),
                    backgroundColor: Colors.redAccent[100],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: ()=>{
                      Navigator.pop(context),
                      _money = 0
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal:10),
                      padding: EdgeInsets.symmetric(vertical:10, horizontal:20),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0,color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text('Cancel', style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),),
                    ),
                  ),
                  
                  GestureDetector(
                    onTap: ()=>{
                      widget.callBack(true),
                      Navigator.pop(context)
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal:10),
                      padding: EdgeInsets.symmetric(vertical:10, horizontal:20),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0,color: Colors.blue),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text('Update', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600),),
                    ),
                  )
                ]
              ),
            ],
          ),

        ],
      )
    );
  }

  Future _dialogDelete() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Stack(
        children: <Widget>[
          SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            contentPadding: EdgeInsets.all(10),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assests/icon/delete.png', width: 80,height:80,)
                ]
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:5),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Are you sure delete this goal?'),
                  ]
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: ()=>{Navigator.pop(context)},
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal:10),
                      padding: EdgeInsets.symmetric(vertical:10, horizontal:20),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0,color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text('Cancel', style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),),
                    ),
                  ),
                  
                  GestureDetector(
                    onTap: ()=>{
                      dbHelper.deleteGoal(widget.id),
                      widget.callBack(true),
                      Navigator.pop(context)
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal:10),
                      padding: EdgeInsets.symmetric(vertical:10, horizontal:20),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0,color: Colors.red),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text('Delete', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600),),
                    ),
                  )
                ]
              ),
            ],
          ),

        ],
      );
      },

    );
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      elevation: 4,
      child: Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 70,
                      width: 100,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(widget.icon))
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${widget.name}\n',
                            style: kTitleTextstyle,
                          ),
                          TextSpan(
                            text: 'end date: ${widget.dateEnd.split(' ')[0]}',
                            style: TextStyle(
                              color: kTextLightColor
                            ),
                          ),
                        ]
                      ),
                    ),
                  ]
                ),
                SizedBox(height:4),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:25),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[300],
                    value: widget.current/widget.totalMoney,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent[100]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('${widget.current} Bath', style: kSizeDefault,),
                      Text('${widget.totalMoney} Bath', style: kSizeDefault,)
                    ]
                  ),
                )
              ]
            ),
            Positioned(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  DropdownButton<String>(
                    dropdownColor: Colors.white,
                    focusColor: Colors.red,
                    icon: Icon(Icons.more_vert, color: Colors.black38,),

                    underline: SizedBox(),
                    onChanged: (String newValue) {
                      if (newValue == 'Update') {
                        _dialogUpdate();
                      } else {
                        _dialogDelete();
                      }
                      setState(() {
                        dropdownValue = newValue;
                        print(dropdownValue);
                      });
                    },
                    items: <String>[
                      'Update',
                      'Delete', 
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                  ),
                ],
              )
            )
          ],
        ),

      )
    );
  }
  
}