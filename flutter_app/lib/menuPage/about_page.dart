

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  _AboutState  createState() => _AboutState();
}

class _AboutState extends State<About> {
  _launchURL(url) async {
    // const url = url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
                          Text(
                            'About',
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
                            'KEB TANG\nVersion 1.0', 
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ]
                      ),
                      SizedBox(height:40),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Text('Developed by',
                        style: TextStyle(
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text('Krirati Kanitapayark'),
                      SizedBox(height:40),
                      Text('Credits',style: TextStyle(
                              fontWeight: FontWeight.w500
                            ),),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _launchURL('https://www.pinterest.com/');
                          });
                        },
                        child: Text('Pinterest.com'),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _launchURL('https://dribbble.com');
                          });
                        },
                        child: Text('Dribble.com'),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _launchURL('https://www.flaticon.com/');
                          });
                        },
                        child: Text('Flaticon.com'),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _launchURL('http://www.freepik.com');
                          });
                        },
                        child: Text('Freepikcom'),
                      ),
                          ],
                        ),
                      ),
                      
                      // Text('Credits\nPinterest.com\nDribble.com\nflaticon.com'),
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