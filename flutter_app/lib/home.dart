import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savemoney/addevent.dart';
import 'package:savemoney/constant.dart';
import 'package:savemoney/dashboard.dart';
import 'package:savemoney/datatarget.dart';
import 'package:savemoney/history.dart';
import 'package:savemoney/services/admob_service.dart';
import 'package:savemoney/setting.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}
class HomeState extends State<Home> {

  //Properties
  final ams = AdMobService();
  var paddingBottom = 0.0;
  int currentTab = 0;
  List<Widget> screens = [
    Dashboard(),
    History(),
    DataTarget(),
    Settings()
  ];// to store tab views
  @override
  void initState() {
    super.initState();
  }

  // Active page (Tab)
  Widget currentScreen = Dashboard(); //initial screen in viewport

  final PageStorageBucket bucket = PageStorageBucket();

  bool clickedCentreFAB = false; //boolean used to handle container animation which expands from the FAB
  int selectedIndex = 0; //to handle which item is currently selected in the bottom app bar
  String text = "Home";

  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: paddingBottom) ,
        child:       Scaffold(
          // backgroundColor: Colors.white,

          body: PageStorage(
            child: currentScreen,
            bucket: bucket,
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.orangeAccent,
            onPressed: (){
              setState(() {
                currentScreen = AddEvent();
                selectedIndex = 5;
              },);
            },
          ),

          //Fab position
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          //Bottom app bar

          bottomNavigationBar: BottomAppBar(
            child: Container(
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    //update the bottom app bar view each time an item is clicked
                    onPressed: () {
                      updateTabSelection(0, "Home");
                      currentScreen = Dashboard();
                    },
                    iconSize: 27.0,
                    icon: Icon(
                      Icons.home,
                      //darken the icon if it is selected or else give it a different color
                      color: selectedIndex == 0
                          ? yellowLowColor
                          : Colors.grey.shade400,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      updateTabSelection(1, "Sechedule");
                      currentScreen = History();
                    },
                    iconSize: 27.0,
                    icon: Icon(
                      Icons.date_range,
                      color: selectedIndex == 1
                          ? yellowLowColor
                          : Colors.grey.shade400,
                    ),
                  ),
                  //to leave space in between the bottom app bar items and below the FAB
                  SizedBox(
                    width: 50.0,
                  ),
                  IconButton(
                    onPressed: () {
                      updateTabSelection(2, "Goal");
                      currentScreen = DataTarget();
                    },
                    iconSize: 27.0,
                    icon: Icon(
                      Icons.assignment,
                      color: selectedIndex == 2
                          ? yellowLowColor
                          : Colors.grey.shade400,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      updateTabSelection(3, "Settings");
                      currentScreen = Settings();
                    },
                    iconSize: 27.0,
                    icon: Icon(
                      Icons.dehaze,
                      color: selectedIndex == 3
                          ? yellowLowColor
                          : Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            //to add a space between the FAB and BottomAppBar
            shape: CircularNotchedRectangle(),
            //color of the BottomAppBar
            color: Colors.white,
          ),
        ),
      )

    );
  }
}
class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(size.width /2, size.height, size.width, size.height-30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}
