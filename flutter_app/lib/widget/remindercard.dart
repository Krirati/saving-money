import 'package:flutter/material.dart';
import 'package:savemoney/constant.dart';
import 'package:savemoney/database/dbHelper.dart';
import 'package:savemoney/database/model.dart';
import 'package:savemoney/history.dart';
import 'package:savemoney/widget/tag_type.dart';

import 'card_event.dart';


class ReminderSlide extends StatefulWidget {
  final ImageProvider type;
  final String eventName;

  const ReminderSlide({Key key, this.type, this.eventName}) : super(key: key);
  @override
  _ReminderSlideState createState() => _ReminderSlideState();
}

class _ReminderSlideState extends State<ReminderSlide> {
  Future<List<EventModel>> events;
  final int _numPages = reminderItems.length;
  final PageController _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  int _currentpage = 0;
  var dbHelper = DBHelper();
  int num = 0 ;
  @override
  void initState() {
    super.initState();
    refreshList();
  } 

  refreshList() {
    setState(() {
      events = dbHelper.getToDay();
    });
  }

  SingleChildScrollView dataTable(List<EventModel> events) {
    var singleChildScrollView = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children:<Widget>[
          for (var i = 0; i < events.length; i++) 
            CardEvent(name: events[i].name, price: events[i].amount, time: events[i].date, icon: events[i].icon,),
        ]
      ) 
    );
    return singleChildScrollView;
  }
  list() {
    return Expanded(
      child: FutureBuilder(
        future: events,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          if(null == snapshot.data || snapshot.data.length == 0){
            return Text('No Data Found');
          }
          return CircularProgressIndicator();
        },
      )
    );
  }
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++ ) {
      list.add(i == _currentpage ? _indicator(true) : _indicator(false));
    }
    return list;
  }
  _reminderSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page -index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 500.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
            MaterialPageRoute(
                builder: (_) => History(reminderItem: reminderItems[index])
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            Container(
              height: 270,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0,3),
                    )
                  ],
              ),
              margin: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 8.0,
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 30.0,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Event',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 25.0,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'Bath',
                            style: TextStyle(
                              color: kTextLightColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                color: kTextLightColor,
                                size: 20,
                                semanticLabel: 'Text to announce in accessibility modes',
                              ),
                              SizedBox(width: 10,),
                              Text(
                                'time',
                                style: TextStyle(
                                  color: kTextLightColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                  ),
                  Positioned(
                    right: 0,
                    top: 10,
                    child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: 200,
                        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assests/images/balance.png'))
                        ),
                      )
                    ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TagType(),
                    ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.orange : Colors.orangeAccent[100],
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: <Widget>[
            Container(
                height: 200.0,
                child:
                PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int index) {
                    setState(() {
                      _currentpage = index;
                    });
                  },
                  itemCount: reminderItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _reminderSelector(index);
                  },)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
            SizedBox(height: 20.0,),
          ],
        )
    ) ;
  }
}

class Remin {
  final String imageUrl;
  final String name;
  final int price;
  final String description;
  final String timestamp;

  Remin({
    this.imageUrl,
    this.name,
    this.price,
    this.description,
    this.timestamp
  });
}
final List<Remin> reminderItems = [
  Remin(
    imageUrl: 'assests/images/income.png',
    name: 'Aloe Vera',
    price: 25,
    description:
    'Aloe vera is a succulent plant species of the genus Aloe. It\'s medicinal uses and air purifying ability make it an awesome plant.',
    timestamp: '6/5/2563 0.12น.',
  ),
  Remin(
    imageUrl: 'assests/images/balance.png',
    name: 'Cool Plant',
    price: 30,
    description:
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porta risus id urna luctus efficitur.',
    timestamp: '6/5/2563 0.12น.',
  ),
  Remin(
    imageUrl: 'assests/images/expenditure.png',
    name: 'Really Cool Plant',
    price: 42,
    description:
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porta risus id urna luctus efficitur. Suspendisse vulputate faucibus est, a vehicula sem eleifend quis.',
    timestamp: '6/5/2563 0.12น.',
  ),
];
