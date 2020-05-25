

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savemoney/database/model.dart';

import '../constant.dart';

class CardEvent extends StatefulWidget {
  final String name;
  final double price;
  final String time;
  final String icon;
  CardEvent({this.name, this.price, this.time, this.icon});
  @override
  _CardEventState createState() => _CardEventState();
}

class _CardEventState extends State<CardEvent> {
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
          child: Image.asset(widget.icon, height: 80, width: 80,))
      ],    
    );
  }
}