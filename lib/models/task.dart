/// Represents a single task in the study planner
class Task {
  // Unique identifier for the task
  final String id;

  // Task title (required)
  final String title;

  // Optional description for additional details
  final String description;

  // When the task is due
  final DateTime dueDate;

  // Optional reminder time
  final DateTime? reminderTime;

  // Whether the task has been completed
  bool isCompleted;

  /// Creates a new task with the given properties
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.reminderTime,
    this.isCompleted = false,
  });

  /// Converts task to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'reminderTime': reminderTime?.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  /// Creates task from JSON data
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDate: DateTime.parse(json['dueDate']),
      reminderTime: json['reminderTime'] != null
          ? DateTime.parse(json['reminderTime'])
          : null,
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}
