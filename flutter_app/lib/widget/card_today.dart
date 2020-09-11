

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import 'tag_type.dart';

class CardToday extends StatefulWidget {
  final String name;
  final double price;
  final String type;
  final String icon;
  final String time;

  CardToday({this.name, this.price, this.type, this.icon, this.time});
  @override
  _CardTodayState createState() => _CardTodayState();
}

class _CardTodayState extends State<CardToday> {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height ;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: Stack(
      children: <Widget>[
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 1,
          child: Container(
            height: 250,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal:20, vertical:8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Text('${widget.name}', style: TextStyle(color: kBodyTextColor,fontSize: width*0.04 ,fontWeight: FontWeight.w600,),),
                      Text('${widget.price} Bath', style: TextStyle(color: kBodyTextColor,fontSize: width*0.038,),),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            color: Colors.orange[200],
                            size: 20,
                            semanticLabel: 'Text to announce in accessibility modes',
                          ),
                          Text(
                            ' ${widget.time.split(' ')[1].split('.')[0]}',
                            style: TextStyle(
                              color: Colors.orange[200],
                              fontSize: width*0.038,
                            ),
                          ),
                        ],
                      ),
                    ]
                ),
                Spacer(),
                Column(
                  children: <Widget>[
                    TagType(type: widget.type),
                    Image.asset(widget.icon, height: height*0.1,)
//                    Padding(
//                      padding: EdgeInsets.only(top: 15),
//                      child: Image.asset(widget.icon, height: height*0.1,),
//                    ),
                  ],
                )
              ],
            ),
          ),
        ),
//        Positioned(
//          top: height*0.05,
//          right: 40,
//          child: Image.asset(widget.icon, height: height*0.1,)
//        ),

//        Row(
//          mainAxisAlignment: MainAxisAlignment.end,
//          children: <Widget>[
//            Padding(
//              padding: EdgeInsets.only(top: 0),
//              child: TagType(type: widget.type)
////              Align(
////                alignment: Alignment.topRight,
////                child: TagType(type: widget.type),
////                ),
//            )
//          ],
//        )
      ],    
    ),
    );

  }

}