

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import 'dialog_event.dart';

class FieldTypeGoal extends StatefulWidget {
  Function(String, String) callbackResultIcon;
  FieldTypeGoal(this.callbackResultIcon);
  @override
  _FieldTypeGoalState createState() => _FieldTypeGoalState();
}

class _FieldTypeGoalState extends State<FieldTypeGoal> {
  String icon;
  String type;
  callbackTypeicon(newType, newIconName) {
    setState(() {
      type = newType;
      icon = newIconName;
      icon = kMapIconGoals[int.parse(icon)];
      // switch (type) {
      //   case 'income':
      //     icon = kMapIconIncome[int.parse(icon)];
      //     break;
      //   case 'expenditure' : {
      //     icon = kMapIconExpenditure[int.parse(icon)];
      //   }
      //   break;
      //   case 'goals' : {
      //     icon = kMapIconGoals[int.parse(icon)];
      //   }
      //   break;
      // }
      widget.callbackResultIcon(type,icon);
    });
    print(type);
    print(icon);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Visibility(
          visible: true,
          child: GestureDetector(
            onTap: ()async {
              await showDialog(
                context: context,
                builder: (BuildContext context) {       
                  return DialogEvent('goals', callbackTypeicon);
                }
              );
            },
            child: Container(
            // height: 80,
            // width: double.infinity,
            decoration: BoxDecoration(
                color: goalColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0,1),
                  )
                ]
            ),
            margin: EdgeInsets.symmetric(horizontal: 2),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical:10, horizontal:12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          elevation: 4,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            height:55,
                            width:55,
                            child: Center(
                              child: Image.asset(
                                (icon == null) ? 'assests/icon/question.png' : icon
                              ,fit: BoxFit.cover,)
                            )
                          ),
                        ),
                        SizedBox(width: 20,),
                        Text(
                          (icon == null) ? 'Select group type'.toUpperCase(): type,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
          ),
        ),
      ),
      ],
    );
  }

}