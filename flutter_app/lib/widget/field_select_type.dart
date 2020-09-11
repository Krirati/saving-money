import 'package:flutter/material.dart';
import 'package:savemoney/widget/dialog_event.dart';
import '../constant.dart';

class FieldType extends StatefulWidget {

  Function(String, String) callbackResultIcon;
  FieldType(this.callbackResultIcon);
  @override
  _FieldTypeState createState() => _FieldTypeState();
}


class _FieldTypeState extends State<FieldType> {
  bool viewVisible = false ;
  Color colorType = Colors.transparent;
  String type;
  String icon;
  void showWidget(){
    setState(() {
      viewVisible = true ;
    });
  }
  void setColor([String s]) {
    setState(() {
      switch(s) {
        case 'income' : {
          colorType = incomeColor;
          type = 'income';
        }
        break;
        case 'expenditure' : {
          colorType = expenditureColor;
          type = 'expenditure';
        }
        break;
        case 'goals' : {
          colorType = goalColor;
          type = 'goals';
        }
        break;
      }
    });
  }
  callbackTypeicon(newType, newIconName) {
    setState(() {
      type = newType;
      icon = newIconName;
      switch (type) {
        case 'income':
          icon = kMapIconIncome[int.parse(icon)];
          break;
        case 'expenditure' : {
          icon = kMapIconExpenditure[int.parse(icon)];
        }
        break;
        case 'goals' : {
          icon = kMapIconGoals[int.parse(icon)];
        }
        break;
      }
      widget.callbackResultIcon(type,icon);
    });
    print(type);
    print(icon);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return  Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    // width: 90,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        showWidget();
                        setColor('income');
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Image.asset('assests/images/income.png',width: 40,),
                          ),
                          Text(
                            'Income',
                            style: TextStyle(
                              color: kTextLightColor,
                              fontSize: width*0.045,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width:10),
                  Container(
                    // width: 90,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        showWidget();
                        setColor('expenditure');
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            // padding: EdgeInsets.only(left: 10,right: 10),
                            child: Image.asset('assests/images/expenditure.png',width: 40,),
                          ),
                          Text(
                            'Expenditure',
                            style: TextStyle(
                                color: kTextLightColor,
                                fontSize: width*0.045,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Visibility(
              visible: true,
              child: GestureDetector(
                onTap: ()async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {       
                      return DialogEvent(type, callbackTypeicon);
                    }
                  );
                },
                child: Container(
                // height: 80,
                // width: double.infinity,
                decoration: BoxDecoration(
                    color: colorType,
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
      )
    ) ;
  }
}