

class GoalModel {
    int id;
    String name;
    String type;
    double total;
    double current;
    String icon;
    String dateFinish;
    String description;
    String status;

  GoalModel({this.id, this.name, this.type, this.total, this.current,this.icon, this.dateFinish, this.description, this.status});

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
      'status': status
    };

  }

  @override
  String toString() {
    return 'GoalModel{id: $id, name: $name, total: $total, current: $current, icon: $icon, dateEnd: $dateFinish, desc: $description}';
  }
}