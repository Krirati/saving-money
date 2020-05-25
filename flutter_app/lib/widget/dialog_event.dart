import 'package:flutter/material.dart';

import '../constant.dart';

class DialogEvent extends StatefulWidget {
  final type;
  Function(String, String) callbackTypeicon;
  DialogEvent(this.type, this.callbackTypeicon);

  @override
  _DialogEventState createState() => _DialogEventState();
}

class _DialogEventState extends State<DialogEvent>{
  List iconData;
  int selectedColor = 0;

@override
  void initState() {
    switch(widget.type) {
        case 'income' : {
          iconData = kMapIconIncome;
        }
        break;
        case 'expenditure' : {
          iconData = kMapIconExpenditure;
        }
        break;
        case 'goals' : {
          iconData = kMapIconGoals;
        }
        break;
      }
    super.initState();
  }
  
  Future<Image> loadList(index) async {
    Image image = Image.asset(iconData.elementAt(index));
    return  image;
  }

  void sendState(type, selectedColor) {
    widget.callbackTypeicon(type, selectedColor.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ), 
      elevation: 2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:10, vertical:5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Select Icon',
                    style: kHeadingTextStyle,),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.save, color: Colors.black, size: 30,),
                      onPressed: () {
                        sendState(widget.type, selectedColor);
                        Navigator.of(context).pop();
                      }
                  ),
                ],
            ),
            Expanded(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: iconData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (BuildContext context,int index, ){
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      children: <Widget>[
                        new GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = index;
                            });
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              FutureBuilder(
                                future: loadList(index),
                                builder: (BuildContext context, AsyncSnapshot<Image> snapshot){
                                  return Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),),
                                    elevation: (index == selectedColor) ? 8 : 1,
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      height:90,
                                      width:90,
                                      child: Center(
                                        child: snapshot.data,
                                      )
                                    ),
                                  );
                                }
                              ),
                              Positioned(
                                child: Visibility(
                                  visible: index == selectedColor,
                                  child: Icon(Icons.done,color: Colors.red ,size: 28),
                                )
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                shrinkWrap: true,
              ),
            )
          ],
        )
      )
    );
  }

}