
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savemoney/menuPage/about_page.dart';
import 'package:savemoney/menuPage/feedback_page.dart';
import 'package:savemoney/menuPage/reset_page.dart';

import 'menuPage/card_category.dart';
import 'widget/dialog_notification.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
  
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    // var size= MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
           Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: null,
                image: DecorationImage(
                  // alignment: Alignment.centerLeft,
                  image: AssetImage('assests/images/page3.png'),
                  fit: BoxFit.cover
                )
              ),
            ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Setting'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height:20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                          title: "Notifications",
                          svgSrc: 'assests/icon/notification.svg',
                          press: () async{
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return  DialogNotification();
                              }
                            );
                          },
                        ),
                        CategoryCard(
                          title: "Reset data",
                          svgSrc: 'assests/icon/database.svg',
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return ResetData();
                              }),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "About",
                          svgSrc: 'assests/icon/info.svg',
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return About();
                              }),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "Feedback",
                          svgSrc: 'assests/icon/bad.svg',
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return FeedBack();
                              }),
                            );                            
                          },
                        ),                      
                      ],
                    )
                  )
                ]
              ),
            )

          ),
        ],
      )
    );
  }
}

