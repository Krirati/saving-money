

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savemoney/database/dbHelper.dart';

class ResetData extends StatefulWidget {
  @override
  _ResetDataState  createState() => _ResetDataState();
}

class _ResetDataState extends State<ResetData> {
  var dbHelper;
  @override
  initState() {
    super.initState();
    dbHelper = DBHelper();
  }

  clearDB() async {
    dbHelper.deleteData();
  }
  Future dialogClear() async {
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
                    Center(
                   
                      child:  Text('Are you sure clear data in this app?'
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
                      clearDB(),
                      Navigator.pop(context)
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal:10),
                      padding: EdgeInsets.symmetric(vertical:10, horizontal:20),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0,color: Colors.red),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text('Clear', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600),),
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
    var size= MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height* .45,
            decoration: BoxDecoration(
              color: Colors.orange[300].withOpacity(0.3),
              // image: DecorationImage(
              //   alignment: Alignment.centerLeft
              //   // image: 
              // )
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
                          Text(
                            'Clear Data',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ]
                      ),
                      SizedBox(height:40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assests/icon/database.svg',
                            width: 150,
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                          ),
                          
                        ],
                      ),
                      SizedBox(height:60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          Text(
                            'Are you sure clear data in this app? \nthat will contain both revenue,\n target expenses, and settings.', 
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ]
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: ()=>{
                              dialogClear()
                            },
                            child: Container(
                              width: 150,
                              padding: EdgeInsets.symmetric(vertical:10, horizontal:20),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.0,color: Colors.orangeAccent),
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.orangeAccent
                              ),
                              child: Text('Clear', 
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