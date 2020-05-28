

class GoalModel {
    int id;
    String name;
    String type;
    double total;
    double current;
    String icon;
    String dateFinish;
    String description;
    //เพิ่ม state ไว้เช็ค progress

  GoalModel({this.id, this.name, this.type, this.total, this.current,this.icon, this.dateFinish, this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'total': total,
      'current': current,
      'icon': icon,
      'dateFinish': dateFinish,
      'description': description,
    };

  }

  @override
  String toString() {
    return 'GoalModel{id: $id, name: $name, amount: }';
  }
}