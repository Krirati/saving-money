import 'package:flutter/material.dart';
import 'package:savemoney/database/dbHelper.dart';
import 'package:savemoney/database/goalmodel.dart';

import '../constant.dart';

class GoalCard extends StatefulWidget{
  final int id;
  final String name;
  final String dateEnd;
  final double totalMoney;
  final double current;
  final String icon;
  final String type;
  final String description;
  final Function(bool) callback;
  GoalCard({this.id, this.name, this.type,this.current,this.dateEnd,this.totalMoney, this.icon, this.description,this.callback});
  @override
  _GoalCardState createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard> {
  String dropdownValue;
  var dbHelper = DBHelper();
  double newCurrent;
  Future _dialogUpdate() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return DialogUpdate(
          id: widget.id,
          name: widget.name,
          type: widget.type,
          current: widget.current,
          dateEnd: widget.dateEnd,
          totalMoney: widget.totalMoney,
          icon: widget.icon,
          description: widget.description,
          callbackCard: callbackCard
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newCurrent = widget.current;
  }
  void callbackCard(update, newAddCurrent) {
    print('callbackCard: $update');
    if (update == true) {
      widget.callback(true);
      // update = false;
      newCurrent = widget.current + newAddCurrent;
    }
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
                    Text('Are you sure delete this goal?'),
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
                      dbHelper.deleteGoal(widget.id),
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
  Future dialogCheck() async {
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
                  Image.asset('assests/icon/tick.png', width: 80,height:80,)
                ]
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:5),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                   
                      child:  Text('You have successfully saved \nyour money for the goal.'
                      ,textAlign: TextAlign.center,),
                    ),
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
                      // dbHelper.deleteGoal(widget.id),
                      widget.callback(true),
                      Navigator.pop(context)
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal:10),
                      padding: EdgeInsets.symmetric(vertical:10, horizontal:20),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0,color: Colors.green),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text('Check', style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600),),
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
                          image: DecorationImage(image: AssetImage(widget.icon))
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${widget.name}\n',
                            style: kTitleTextstyle,
                          ),
                          TextSpan(
                            text: 'end date: ${widget.dateEnd.split(' ')[0]}',
                            style: TextStyle(
                              color: kTextLightColor
                            ),
                          ),
                        ]
                      ),
                    ),
                  ]
                ),
                SizedBox(height:4),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:25),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[300],
                    value: widget.current/widget.totalMoney,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent[100]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('${newCurrent} Bath'),
                      Text('${widget.totalMoney} Bath')
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
                      if (newValue == 'Update') {
                        _dialogUpdate();
                      } else if (newValue == 'Check') {
                        dialogCheck();
                      } else if (newValue == 'History') {

                      }
                      else {
                        _dialogDelete();
                      }
                      setState(() {
                        dropdownValue = newValue;
                        print(dropdownValue);
                      });
                    },
                    items: <String>[
                      'Check',
                      'Update',
                      'History',
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
class DialogUpdate extends StatefulWidget {
  final int id;
  final String name;
  final String type;
  final String dateEnd;
  final double totalMoney;
  final double current;
  final String icon;
  final String description;
  final Function(bool,double) callbackCard;
  const DialogUpdate({ this.id, this.name, this.type,this.dateEnd, this.totalMoney, this.current, this.icon, this.description, this.callbackCard});
  @override
  _DialogUpdateState createState() => new _DialogUpdateState();
}

class _DialogUpdateState extends State<DialogUpdate> {
  int _counter = 0;
  var currentController = TextEditingController();
  String current;
  var dbHelper = DBHelper();
  void _incrementCounter() {
    setState(() {
      _counter++;
      currentController.text = _counter.toString();
      _counter = int.parse(currentController.text);
      
    });
  }
  void _decrementCounter() {
    setState(() {
      _counter--;
      currentController.text = _counter.toString();
      _counter = int.parse(currentController.text);
      
    });
  }
  Future dialogError() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
        });
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
                    Text('You have exceeded the target amount.'),
                  ]
                ),
              ),
            ],
          ),

        ],
      );
      },

    );
  }
  void updateGoal()async {
    if (widget.current + double.parse(currentController.text)>  widget.totalMoney) {
      print('more');
      dialogError();
    }
    else {
      GoalModel g = GoalModel(
        id: widget.id,
        name: widget.name,
        type: widget.type,
        total: widget.totalMoney,
        current: widget.current + double.parse(currentController.text),
        icon: widget.icon,
        dateFinish: widget.dateEnd,
        description: widget.description
      );
      print(double.parse(currentController.text));
      await dbHelper.updateGoal(g);
      widget.callbackCard(true,double.parse(currentController.text));
      Navigator.pop(context);
    }

  }
  GoalModel g;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ), 
      elevation: 2,
      child: Wrap(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget> [
                SafeArea(
                  minimum: EdgeInsets.symmetric(vertical: 15, horizontal:10 ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Update current money',
                            style: kHeadingTextStyle,),
                          Spacer(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(widget.icon, width: 80,height:80,)
                        ]
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FloatingActionButton(
                            backgroundColor: Colors.redAccent[100],
                            onPressed: _decrementCounter,
                            tooltip: 'Decrement',
                            child: Icon(Icons.remove, ),
                          ),
                          SizedBox(width:10),
                          Container(
                            width: 100,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: currentController,
                              decoration: InputDecoration(
                                hintText: 'Amount',
                                contentPadding: EdgeInsets.all(10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  )
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width:10),
                          FloatingActionButton(
                            onPressed: _incrementCounter,
                            backgroundColor: Colors.green[200],
                            tooltip: 'Increment',
                            child: Icon(Icons.add),
                          ),
                        ]
                      ),
                      SizedBox(height:10),
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
                              updateGoal()
                            },
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
                    ]
                  ),
                )
              ]
            ),
          )
        ]
        )
      );
  }
}