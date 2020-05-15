import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../constant.dart';

class ExpenditureScreen  extends StatefulWidget{

  @override
 _ExpenditureScreenState createState() => _ExpenditureScreenState();

}


class _ExpenditureScreenState extends State<ExpenditureScreen> {
  GlobalKey actionKey;
  String dropdownValue;
  @override
  void initState() {
    actionKey = LabeledGlobalKey('mode');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
          },
            child: ListView(
            padding: EdgeInsets.symmetric(vertical:5, horizontal: 15),
            addAutomaticKeepAlives: true,
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(10)),

                // dropdown below..
                child: Row(
                  children: <Widget>[
                    Text('Select Rang'.toUpperCase(), style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w300)),
                    Spacer(),
                    DropdownButton<String>(
                      dropdownColor: Colors.white,
                        value: dropdownValue,
                        // iconDisabledColor: Colors.white,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.white,),
                        iconSize: 42,
                        underline: SizedBox(),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                            print(dropdownValue);
                          });
                        },
                        items: <String>[
                          'Day',
                          'Week',
                          'Month',
                          'Year'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value , style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600)),
                          );
                        }).toList()
                    ),
                  ],
                )
              ),
              SizedBox(height:10),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                elevation: 4,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: DataTable(
                    columnSpacing:70,
                    columns: [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Time')),
                      DataColumn(label: Text('Price')),
                    ], 
                    rows: [
                      DataRow(cells: [
                        DataCell(Row( children: <Widget>[
                          Icon(Icons.fastfood, color: kTextLightColor,),
                          SizedBox(width: 3),
                          Text('data')
                        ], )),
                        DataCell(Text('วันนี้')),
                        DataCell(Text('1000'),showEditIcon: true),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('เมื่อวาน')),
                        DataCell(Text('วันนี้')),
                        DataCell(Text('1000'),showEditIcon: true),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('สัปดาห์ล่าสุด')),
                        DataCell(Text('1000')),
                        DataCell(Text('วันนี้'),showEditIcon: true),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('เดือนล่าสุด')),
                        DataCell(Text('1000')),
                        DataCell(Text('วันนี้'),showEditIcon: true),
                      ]),
                      
                    ]
                  ),
                )
              ),

            ],
          )
        )

      ),
    );
  } 
}