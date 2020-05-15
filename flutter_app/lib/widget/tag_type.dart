import 'package:flutter/material.dart';

class TagType extends StatefulWidget {
  @override
  _TagTypeState createState() => _TagTypeState();
}

class _TagTypeState extends State<TagType> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15))
      ),
      margin: EdgeInsets.symmetric(vertical: 16),
//      alignment: FractionalOffset.topRight,
      padding: EdgeInsets.fromLTRB(15, 2, 6, 2),
     child: Text(
         'Income',
         style: TextStyle(
             color: Colors.white,
             fontWeight: FontWeight.w500
         ),
       ),
    );
  }
  
}