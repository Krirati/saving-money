
class EventModel {
   int id;
   String name;
   String type;
   double amount;
   String icon;
   String date;
   String description;

  EventModel({this.id, this.name, this.type, this.amount, this.icon, this.date, this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'amount': amount,
      'icon': icon,
      'date': date,
      'description': description,
    };

  }

  @override
  String toString() {
    return 'EventModel{id: $id, name: $name, amount: }';
  }
}