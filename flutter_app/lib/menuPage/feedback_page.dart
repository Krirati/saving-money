import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState  createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  var describeController = TextEditingController();
  bool start1 = false;
  bool start2 = false;
  bool start3 = false;
  bool start4 = false;
  bool start5 = true;
  String rate;
  _sendEmail() async {
    if (start1 == true) {
      rate = '1';
    } else if (start2 == true) {
      rate = '2';
    } else if (start3 == true) {
      rate = '3';
    } else if (start4 == true) {
      rate = '4';
    } else {
      rate = '5';
    }
    final String _email = 'mailto:ninekani@gmail.com?subject=keptang_feedback&body="rate $rate\n ${describeController.text}"';
    try {
      await launch(_email);
      print('send done');
    } catch (e) {
      throw 'Could not send mail';
    }
  }
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height* .99,
            decoration: BoxDecoration(
              image: DecorationImage(
                // alignment: Alignment.centerLeft,
                image: AssetImage('assests/images/page4.png'),
                fit: BoxFit.fitWidth
              )
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          // IconButton(
                          //   icon: new Icon(Icons.arrow_back),
                          //   onPressed: () {
                          //     Navigator.pop(context);
                          //   },
                          // ),
                          Text(
                            'Shere Your feed back',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ]
                      ),
                      SizedBox(height:20),
                      Text('Do you have a suggestion found some bug?\nlet us know in the field below.'),
                      SizedBox(height: 20),
                      Text('How was your experiance?'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget> [
                          IconButton(
                            icon: Icon(
                              Icons.sentiment_very_dissatisfied, 
                              size: 40,
                              color: (start1 == true) ? Colors.orange: Colors.grey),
                            onPressed: () {
                              setState(() {
                                start1 = true;
                                start2 = false;
                                start3 = false;
                                start4 = false;
                                start5 = false;
                              });
                            }
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.sentiment_dissatisfied, 
                              size: 40,
                              color: (start2 == true) ? Colors.orange: Colors.grey),
                            onPressed: () {
                              setState(() {
                                start1 = false;
                                start2 = true;
                                start3 = false;
                                start4 = false;
                                start5 = false;
                              });                              
                            }
                          ), 
                          IconButton(
                            icon: Icon(
                              Icons.sentiment_neutral, 
                              size: 40,
                              color: (start3 == true) ? Colors.orange: Colors.grey),
                            onPressed: () {
                              setState(() {
                                start1 = false;
                                start2 = false;
                                start3 = true;
                                start4 = false;
                                start5 = false;
                              });                              
                            }
                          ), 
                          IconButton(
                            icon: Icon(
                              Icons.sentiment_satisfied, 
                              size: 40,
                              color: (start4 == true) ? Colors.orange: Colors.grey),
                             onPressed: () {
                              setState(() {
                                start1 = false;
                                start2 = false;
                                start3 = false;
                                start4 = true;
                                start5 = false;
                              });                              
                            }
                          ), 
                          IconButton(
                            icon: Icon(
                              Icons.sentiment_very_satisfied, 
                              size: 40,
                              color: (start5 == true) ? Colors.orange: Colors.grey),
                            onPressed: () {
                              setState(() {
                                start1 = false;
                                start2 = false;
                                start3 = false;
                                start4 = false;
                                start5 = true;
                              });                              
                            }
                          ),  
                        ]
                      ),
                      SizedBox(height: 20),
                      Text('Describe your experiance'),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 8,
                        controller: describeController,
                        decoration: InputDecoration(
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
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: ()=>{
                              _sendEmail()
                            },
                            child: Container(
                              width: 150,
                              padding: EdgeInsets.symmetric(vertical:10, horizontal:20),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.0,color: Colors.orangeAccent),
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.orangeAccent
                              ),
                              child: Text('Send', 
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: ()=>{
                              Navigator.pop(context)
                            },
                            child: Container(
                              // color: Colors.black,
                              width: 150,
                              padding: EdgeInsets.symmetric(vertical:10, horizontal:20),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.0,color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey[300]
                              ),
                              child: Text('Cancel', 
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ]
                      ),


                    ]
                  ),
                ]
              )
              
            )

          ),
        ],
      )
    );
  }

}