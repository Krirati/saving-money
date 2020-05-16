
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savemoney/constant.dart';
import 'package:savemoney/widget/dialog_notification.dart';
import 'package:savemoney/widget/remindercard.dart';

import 'home.dart';


Color kPrimaryBlue = Color(0xff3c528b);
Color kBackground = Color(0xfff9fbe7);
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();

}

class _DashboardState extends State<Dashboard>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 200),
          child: ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xffffe0b2),
                      Color(0xffffa726)
                    ],
                  ),
  //                image: DecorationImage(image: AssetImage('assests/images/balance.png'))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,right: 12,top: 30,bottom: 8
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () async{
                              print("noti");
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                              
                                  return  DialogNotification();
                                });
                            },
                            child: Icon(Icons.notifications, color: Colors.white,size: 35,),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[                    
                            Opacity(
                              opacity: 0.1,
                              child: CustomPaint(
                                painter: ShapesPainter(),
                              ),  
                            ),
                          ],
                        ),
    

                        SvgPicture.asset(
                          'assests/icon/finance.svg',
                          width: 150,
  //                        fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                        Positioned(
                            top: 4,
                          left: 200,
                          child: Text(
                            'Keb Tang',
                            style: kHeadingTextStyle.copyWith(
                              color: Colors.white
                            ),
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(25, 1, 25, 15),
              child: Text('Event Lists',
              style: kTitleTextstyle,
              ),
            ),
            CardListGroup(name: 'Balance', money: '500',img: AssetImage('assests/images/balance.png'),),
            SizedBox(height: 15,),
            CardListGroup(name: 'Income', money: '300',img: AssetImage('assests/images/income.png'),),
            SizedBox(height: 15,),
            CardListGroup(name: 'Expenditure', money: '5000', img: AssetImage('assests/images/expenditure.png'),),
            SizedBox(height: 15,),
            CardListGroup(name: 'Saving', money: '500', img: AssetImage('assests/images/expenditure.png'),),
            SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 1, 25, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
                  Spacer(),
                  Text(
                    "See more",
                    style: TextStyle(
                      color: yellowLowColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            ReminderSlide()
          ],
        ),
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
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius:4,
                offset: Offset(0,3),
              )
            ]
          ),
          margin: EdgeInsets.symmetric(horizontal: 45),
          child: Center(
            child: Row(
              children: <Widget>[
                SizedBox(width: 5),
                Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      image: DecorationImage(image: widget.img)
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.name,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${widget.money} Bath',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20),
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