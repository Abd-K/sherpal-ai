class Goal {
  int? id;
  String title;
  String description;
  String deadline;
  String lastUpdated;
  String category;

  Goal({
    this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.lastUpdated,
    required this.category,
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
    );
  }
}
