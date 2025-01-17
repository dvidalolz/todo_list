class Todo {
  final String name;
  final String description;
  final DateTime? dueDate;
  bool isCompleted;  // New field to track completion status

  Todo({
    required this.name,
    required this.description,
    this.dueDate,
    this.isCompleted = false, // Default to false
  });

  // Method to toggle completion status
  void toggleCompletion() {
    isCompleted = !isCompleted;
  }

  // Convert Todo to Map for easier JSON serialization if needed
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'dueDate': dueDate?.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  // Convert Map back to Todo
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}