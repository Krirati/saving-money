import 'package:flutter/material.dart';

import '../constant.dart';

class GoalCard extends StatefulWidget{
  @override
  _GoalCardState createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard> {
  String dropdownValue;
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
                          image: DecorationImage(image: AssetImage('assests/images/balance.png'))
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Reminder today\n',
                            style: kTitleTextstyle,
                          ),
                          TextSpan(
                            text: 'Newest update March28',
                            style: TextStyle(
                              color: kTextLightColor
                            ),
                          ),
                        ]
                      ),
                    ),
                  ]
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:25),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[300],
                    value: 0.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent[100]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('0 Bath'),
                      Text('1000 Bath')
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