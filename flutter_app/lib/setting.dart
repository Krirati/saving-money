import 'package:flutter/material.dart';

import 'constant.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
  
}

class _SettingsState extends State<Settings>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: GridView.builder(
            itemCount: kMapIconIncome.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
            itemBuilder: (BuildContext context, int index) {
              return CardItem(pathImage: kMapIconIncome[1],);
            }
          )
    );
  }
  
}

class CardItem extends StatelessWidget {
  final pathImage;

  const CardItem({this.pathImage});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: pathImage, 
        child: Container(
          padding: EdgeInsets.all(15),
          height:90,
          width:90,
          child: Center(
          child: Image.asset(pathImage),
          )
        ),
      ),
    );
  }

}