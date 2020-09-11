import 'package:flutter/material.dart';
import 'package:savemoney/tab_schedule/balance.dart';
import 'package:savemoney/tab_schedule/income.dart';

import 'tab_schedule/expenditure.dart';
import 'widget/dialog_notification.dart';

class History extends StatefulWidget {
//  final Remin reminderItem;

//  History({this.reminderItem});

  @override
  _HistoryState createState() => _HistoryState();

}

class _HistoryState extends State<History>{
  int _currentPage = 0 ;
  final controller = PageController(initialPage: 0);
  setCurrent(page) {
    setState(() {
      _currentPage = page;
    });
  }
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  void bottomTapped(int index) {
    setState(() {
      _currentPage = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
                image: AssetImage('assests/images/page2.png'),
                fit: BoxFit.cover
              )
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Schedule'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
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
                          ),
//                          IconButton(
//                              icon: Icon(Icons.date_range , color: Colors.black, size: 30,) ,
//                              onPressed: () async{
//                                print("notification");
//                                await showDialog(
//                                    context: context,
//                                    builder: (BuildContext context) {
//
//                                      return  DialogNotification();
//                                    });
//                              }
//                          ),
                        ],
                      )

                    ],
                  ),
                  
                ]
              ),
            )
          ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.only(top:80),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: ()=>{
                      bottomTapped(0)
                    },
                    child: Container(
                      width: width *0.25,
                      margin: EdgeInsets.symmetric(horizontal:5),
                      padding: EdgeInsets.symmetric(vertical:10, horizontal:20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: (_currentPage == 0) ? Colors.orange[200] :Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                        color: (_currentPage == 0) ? Colors.orange[200] :null,
                      ),

                      child: Text('Balance', 
                      style: TextStyle(
                        color:  (_currentPage == 0) ? Colors.white :Colors.black,
                        fontWeight: (_currentPage == 0) ? FontWeight.w700: FontWeight.w600,
                        fontSize:14,
                      ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>{
                      bottomTapped(1)
                    },
                    child: Container(
                      width: width *0.25,
                      margin: EdgeInsets.symmetric(horizontal:5),
                      padding: EdgeInsets.symmetric(vertical:10, horizontal:20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: (_currentPage == 1) ? Colors.orange[200] :Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                        color: (_currentPage == 1) ? Colors.orange[200] :null,
                      ),
                      child: Text('Income',
                        style: TextStyle(
                          color: (_currentPage == 1) ? Colors.white :Colors.black,
                          fontWeight: (_currentPage == 1) ? FontWeight.w700: FontWeight.w600,
                          fontSize:14,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>{
                      bottomTapped(2)
                    },
                    child: Container(
                      width: width *0.25,
                      margin: EdgeInsets.symmetric(horizontal:5),
                      padding: EdgeInsets.symmetric(vertical:10, horizontal:20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: (_currentPage == 2) ? Colors.orange[200] :Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                        color: (_currentPage == 2) ? Colors.orange[200] : null,
                      ),
                      child: Text('Expend', 
                        style: TextStyle(
                          color:  (_currentPage == 2) ? Colors.white :Colors.black,
                          fontWeight: (_currentPage == 2) ? FontWeight.w700: FontWeight.w600,
                          fontSize:14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )

          ),
          Positioned(
            // height: double.infinity,
            child: Container(
              margin: EdgeInsets.only(top:130),
              height: double.infinity,
              child:   PageView(
                onPageChanged: (val) => {
                  setCurrent(val),

                },
                controller: pageController,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  BalanceScreen(),
                  IncomeScreen(),
                  ExpenditureScreen(),
                ],
              ),
            )
          
          ),

            // DefaultTabController(
            //   length: 3,
            //   child: Scaffold(
            //     appBar: AppBar(
            //       automaticallyImplyLeading: false,
            //       backgroundColor: Colors.orange[200],
            //       elevation: 0,
            //       flexibleSpace: TabBar(
            //           unselectedLabelColor: Colors.black,
            //           indicatorSize: TabBarIndicatorSize.label,
            //           indicator: BoxDecoration(
            //               borderRadius: BorderRadius.circular(20),
            //               color: Colors.white),
            //           tabs: [
            //             Tab(
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(20),
            //                     border: Border.all(color: Colors.white, width: 2)),
            //                 child: Align(
            //                   alignment: Alignment.center,
            //                   child: Text("Balance"),
            //                 ),
            //               ),
            //             ),
            //             Tab(
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(20),
            //                     border: Border.all(color: Colors.white, width: 2)),
            //                 child: Align(
            //                   alignment: Alignment.center,
            //                   child: Text("Income"),
            //                 ),
            //               ),
            //             ),
            //             Tab(
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(20),
            //                     border: Border.all(color: Colors.white, width: 2)),
            //                 child: Align(
            //                   alignment: Alignment.center,
            //                   child: Text("Expenditure"),
            //                 ),
            //               ),
            //             ),
                        
            //           ]),
            //     ),
            //     body:  Stack(
            //       children: <Widget>[
            //       // Container(
            //       //   decoration: new BoxDecoration(
            //       //     gradient: new LinearGradient(
            //       //       begin: Alignment.topRight,
            //       //       end: Alignment.bottomLeft,
            //       //       colors: [Colors.orange[200], Colors.orange[200]]
            //       //     ),
            //       //   ),
            //       //   height: 85,
            //       // ),
            //       Positioned(
            //         child: TabBarView(children: [
            //           BalanceScreen(),
            //           IncomeScreen(),
            //           ExpenditureScreen(),
            //           ]
            //         ),
            //       ),
                    
            //       ],
            //     ),
            //   )
            // )
        ]
      ),
    );  
  }
}