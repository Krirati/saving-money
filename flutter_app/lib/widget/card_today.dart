

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
      children: <Widget>[
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 4,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal:20, vertical:16),
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
          top: 20,
          right: 40,
          child: Image.asset(widget.icon, height: 80, width: 80,)
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Align(
                alignment: Alignment.topRight,
                child: TagType(type: widget.type),
                ),
            )
          ],
        )
      ],    
    ),
    );

  }

}