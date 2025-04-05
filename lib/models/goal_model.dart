class Goal {
  int? id;
  String title;
  String description;
  String deadline;
  String lastUpdated;
  String category;
  String? goalType; // work, fitness, general
  String? measurementType; // time, checkbox, reps, weight, distance
  String? targetValue;
  String? currentValue;
  int? parentId; // For objectives (sub-goals)
  bool isCompleted;
  String? bestValue;

  Goal({
    this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.lastUpdated,
    required this.category,
    this.goalType,
    this.measurementType,
    this.targetValue,
    this.currentValue,
    this.parentId,
    this.isCompleted = false,
    this.bestValue,
  });

  // Convert a Goal object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadline': deadline,
      'lastUpdated': lastUpdated,
      'category': category,
      'goalType': goalType,
      'measurementType': measurementType,
      'targetValue': targetValue,
      'currentValue': currentValue,
      'parentId': parentId,
      'isCompleted': isCompleted ? 1 : 0,
      'bestValue': bestValue,
    };
  }

  // Create a Goal object from a Map
  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      deadline: map['deadline'],
      lastUpdated: map['lastUpdated'],
      category: map['category'],
      goalType: map['goalType'],
      measurementType: map['measurementType'],
      targetValue: map['targetValue'],
      currentValue: map['currentValue'],
      parentId: map['parentId'],
      isCompleted: map['isCompleted'] == 1,
      bestValue: map['bestValue'],
    );
  }
}
