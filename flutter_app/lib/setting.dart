
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constant.dart';
import 'database/dbHelper.dart';
import 'database/model.dart';
import 'widget/dialog_notification.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
  
}

class _SettingsState extends State<Settings> {
  Future<List<EventModel>> events;
  var nameController = TextEditingController();
  final formKeyName = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;
  int curUserId;
  String name;
  double amount;
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    refreshList();
    print(dbHelper.sumAll('income'));
  } 

  refreshList() {
    setState(() {
      events = dbHelper.getEvents();
    });
  }
  SingleChildScrollView dataTable(List<EventModel> events) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('NAME'),
          ),
          DataColumn(
            label: Text('TYPE'),
          ),
          DataColumn(
            label: Text('Delete')
            )
        ],
        rows: events.map((event) => DataRow(
          cells: [
            DataCell(
              Text(event.name),
              onTap: () {
                setState(() {
                  isUpdating = true;
                  curUserId = event.id;
                });
                nameController.text = event.name;
              },
            ),
            DataCell(
              Text('${event.type}'),
            ),
            DataCell(
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  dbHelper.delete(event.id);
                  refreshList();
                },
              )
            )
          ])
          ).toList(),
        ),
    );
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

  clearField() {
    setState(() {
      nameController.clear();

    });
  }
  validate() {
    if (formKeyName.currentState.validate()) {
      formKeyName.currentState.save();
      if(isUpdating) {
        print(curUserId.toString());
        EventModel e = EventModel(id: curUserId, name: nameController.text,type: 'goals' ,amount: 100.30, icon: 'bye', description: 'woww');
        dbHelper.update(e);
        setState(() {
          isUpdating = false;
        });
      } else {
        EventModel e = EventModel(name: nameController.text, type: 'income', amount: 150.10, icon: 'welcome',date: DateTime.now().toString(), description: 'desss');
        dbHelper.insert(e);
      }
      clearField();
      refreshList();
    }
  }
  form() {
    return Form(
      key: formKeyName,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (val) => val.length == 0 ? 'Enter Name' : null,
              onSaved: (val) => name = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: validate,
                  child: Text(isUpdating ? 'Update': 'Save'),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                  },
                  child: Text('Cancel'),
                )
              ],
            )
          ]
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Goals',style: kAppbar,),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.notifications),
              onPressed: () async{
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return  DialogNotification();
                  }
                );
              },
            )
          ],
          elevation: 0,
        ),
        body: Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                form(),
                list(),
              ],
            ),
          ),
    );
  }
  
}