

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savemoney/database/dbHelper.dart';
import 'package:savemoney/database/model.dart';

import '../constant.dart';

class CardEvent extends StatefulWidget {
  final int id;
  final String name;
  final double price;
  final String time;
  final String icon;
  final Function callback;
  CardEvent({this.id, this.name, this.price, this.time, this.icon,this.callback});
  @override
  _CardEventState createState() => _CardEventState();
}

class _CardEventState extends State<CardEvent> {
    String dropdownValue;
    var dbHelper = DBHelper();
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
              Text('data'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: ()=>{
                      Navigator.pop(context)
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
                    onTap: ()=>{},
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
                    Text('Are you sure delete this event?'),
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
                      dbHelper.delete(widget.id),
                      widget.callback(true),
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
    return Stack(
      children: <Widget>[
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 4,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal:20, vertical:10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Text('${widget.name}', style: kHeadingTextStyle,),
                Text('${widget.price} Bath', style: TextStyle(color: kBodyTextColor),),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: Colors.orange[200],
                      size: 20,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Text(
                      ' ${widget.time.split('.')[0]}',
                        style: TextStyle(
                        color: Colors.orange[200]
                      ),
                    ),
                  ],
                ),
              ]
            ),
          ),
        ),
        Positioned(
          right: 30,
          child: Image.asset(widget.icon, height: 80, width: 80,)
        ),
        Positioned(
          right: 10,
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
    );
  }
}