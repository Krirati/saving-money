import 'package:flutter/material.dart';

import '../constant.dart';

class TagType extends StatefulWidget {
  final String type;
  TagType({this.type});
  @override
  _TagTypeState createState() => _TagTypeState();
}

class _TagTypeState extends State<TagType> {
  Color color;
  @override
  void initState() {
    super.initState();
    if (widget.type == 'income') {
      color = incomeColor;
    } else if (widget.type == 'goals') {
      color = goalColor;
    }
    else {
      color = expenditureColor;
    } 
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: color ,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15))
      ),
      margin: EdgeInsets.symmetric(vertical: 16),
//      alignment: FractionalOffset.topRight,
      padding: EdgeInsets.fromLTRB(15, 2, 6, 2),
     child: Text(
         widget.type,
         style: TextStyle(
             color: Colors.white,
             fontWeight: FontWeight.w500,
             fontSize: width*0.04,
         ),
       ),
    );
  }
  
}