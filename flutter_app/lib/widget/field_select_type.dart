import 'package:flutter/material.dart';

import '../constant.dart';

class FieldType extends StatefulWidget {
//  final bool visible;
//  final String type  ;
//
//  const FieldType({Key key, this.visible, this.type}) : super(key: key);
  @override
  _FieldTypeState createState() => _FieldTypeState();
}


class _FieldTypeState extends State<FieldType> {
  bool viewVisible = false ;
  Color colorType = Colors.transparent;

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
        }
        break;
        case 'expenditure' : {
          colorType = expenditureColor;
        }
        break;
        case 'goals' : {
          colorType = goalColor;
        }
        break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 90,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        showWidget();
                        setColor('income');
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Image.asset('assests/images/income.png'),
                          ),
                          Text(
                            'Income',
                            style: TextStyle(
                                color: kTextLightColor
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 90,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        showWidget();
                        setColor('expenditure');
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Image.asset('assests/images/expenditure.png'),
                          ),
                          Text(
                            'Expenditure',
                            style: TextStyle(
                                color: kTextLightColor
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 90,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        showWidget();
                        setColor('goals');
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Image.asset('assests/images/goalIcon.png'),
                          ),
                          Text(
                            'Goals',
                            style: TextStyle(
                                color: kTextLightColor
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
              visible: viewVisible,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    color: colorType,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0,1),
                      )
                    ]
                ),
                margin: EdgeInsets.symmetric(horizontal: 45),
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            ' Bath',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
          ),
        ],
      )
    ) ;
  }
}