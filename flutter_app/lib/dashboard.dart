
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savemoney/constant.dart';
import 'package:savemoney/history.dart';
import 'package:savemoney/widget/card_today.dart';
import 'package:savemoney/widget/dialog_notification.dart';

import 'database/dbHelper.dart';
import 'database/model.dart';



Color kPrimaryBlue = Color(0xff3c528b);
Color kBackground = Color(0xfff9fbe7);
class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();

}

class _DashboardState extends State<Dashboard>{
  var dbHelper = DBHelper();
  String timeNow = DateTime.now().toString();
  Future<List<EventModel>> events;

  Future<double> loadSum(name) async {
    var result = dbHelper.sumAll(name);
    return result;
  }
  Future<double> loadBalance() async {
    var result = dbHelper.balance();
    return result;
  }
  Future<double> loadGoal() async {
    var result = dbHelper.sumGoal();
    return result;
  }
  void initState() {
    super.initState();
    refreshList();
    
  } 

  refreshList() {
    setState(() {
      events = dbHelper.getToDay();
    });
  }

  ListView dataTable(List<EventModel> events) {
    var singleChildScrollView = ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: events.length,
      itemBuilder: (context, index) {
        print(index);
        return Container(
          padding: EdgeInsets.symmetric(horizontal:1),
          width: (events.length == 1) ? MediaQuery.of(context).size.width *0.9 :  MediaQuery.of(context).size.width *0.7,
          child: CardToday(
            name: events[index].name,
            type: events[index].type,
            icon: events[index].icon,
            price: events[index].amount,
            time: events[index].date,
          )
        );

        
      }
    );
    return singleChildScrollView;
  }
  list() {
    return 
       FutureBuilder(
        future: events,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.length != 0) {
            return Container(
              padding: EdgeInsets.symmetric( vertical: 5.0),
              height: MediaQuery.of(context).size.height *0.19 ,
              child: dataTable(snapshot.data),

            );
          }
          if(null == snapshot.data || snapshot.data.length == 0){
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical:10),
              child: Text("Today don't have  event")
            );
            
          // return CircularProgressIndicator();  
          }
          return CircularProgressIndicator();
        },
      );
    
  }
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children:<Widget>[
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: null,
              image: DecorationImage(
                // alignment: Alignment.centerLeft,
                image: AssetImage('assests/images/page1.png'),
                fit: BoxFit.fitWidth
              )
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Kep tang'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.notifications, color: Colors.black, size: 30,) , 
                        onPressed: () async{
                          print("notification");
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                          
                              return  DialogNotification();
                            });
                        }
                      )
                    ],
                  ),
                  Text(
                    "Let's record your expenditure.",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.8)
                    ),
                  ),
                  SizedBox(height:20),
                  Text('Overview',
                     style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.8)
                    ),
                  ),
                  SizedBox(height:10),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FutureBuilder(
                            future: loadBalance(),
                            builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                              return CardListGroup(
                                name: 'Balance', 
                                money: snapshot.data.toString(),
                                img: AssetImage('assests/images/balance.png'),);
                            }
                          ),         
                          // SizedBox(height: 15,),
                          FutureBuilder(
                            future: loadSum('income'),
                            builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                              return CardListGroup(
                                name: 'Income', 
                                money: snapshot.data.toString(),
                                img: AssetImage('assests/images/income.png'),);
                            }
                          ),
                        ]
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FutureBuilder(
                            future: loadSum('expenditure'),
                            builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                              return CardListGroup(
                                name: 'Expenditure', 
                                money: snapshot.data.toString(), 
                                img: AssetImage('assests/images/expenditure.png'),
                              );
                            }
                          ),
                          SizedBox(height: 15,),
                          FutureBuilder(
                            future: loadGoal(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return CardListGroup(
                                  name: 'Saving', 
                                  money: snapshot.data.toString(), 
                                  img: AssetImage('assests/images/goalIcon.png'),
                                );
                              }
                              if(null == snapshot.data || snapshot.data.length == 0){
                                return CardListGroup(
                                  name: 'No data', 
                                  money: '0', 
                                  img: AssetImage('assests/images/goalIcon.png'),
                                );
                              }
                              return CircularProgressIndicator();
                            
                            }
                          ),
                        ],
                      ),
                    ]
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Reminder today\n',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.8)
                              ),
                            ),
                            TextSpan(
                              text: 'Last update ${timeNow.split(' ')[0]}',
                              style: TextStyle(
                                color: kTextLightColor
                              ),
                            ),
                          ]
                        ),
                      ),
                      // FlatButton(
                      //   onPressed: () {
                      //     Navigator.push(context,
                      //       MaterialPageRoute(
                      //           builder: (_) => History()
                      //       ),
                      //     );

                      //   }, 
                      //   child: Text(
                      //     "See more",
                      //     style: TextStyle(
                      //       color: Colors.orangeAccent,
                      //       fontWeight: FontWeight.w600,
                      //       fontSize: 16
                      //     ),
                      //   )
                      // )
                    ],
                  ),
                  list(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: _buildPageIndicator(),
                  // ),
                ],
              ),
            )
          ),
        ]
      ),
    );
  }
}

class CardListGroup extends StatefulWidget {
  final String name;
  final String money;
  final ImageProvider img;
  const CardListGroup({this.name, this.money, this.img});
  
  @override
  _CardGroupState createState() => _CardGroupState();
}

class _CardGroupState extends State<CardListGroup> {
  bool vis = false;
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0.2,
                blurRadius:1,
                offset: Offset(0,1),
              )
            ]
          ),
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: Center(
            child: Row(
              children: <Widget>[
                // SizedBox(width: 5),
                Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                      image: DecorationImage(image: widget.img)
                  ),
                ),
                SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.name,
                      style: TextStyle(
                        color: Colors.black,
                        // fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${widget.money} Bath',
                      style: TextStyle(
                          color: Colors.grey,
                          // fontSize: 20
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // set the paint color to be white
    paint.color = Colors.white;

    // Create a rectangle with size and width same as the canvas
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // draw the rectangle using the paint
    canvas.drawRect(rect, paint);

    paint.color = Colors.yellow;

    // create a path
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    // close the path to form a bounded shape
    path.close();

    canvas.drawPath(path, paint);

    // set the color property of the paint
    paint.color = Colors.orange;

    // center of the canvas is (x,y) => (width/2, height/2)
    var center = Offset(size.width / 2, size.height / 2);

    // draw the circle with center having radius 75.0
    canvas.drawCircle(center, 75.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}