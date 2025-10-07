import '../models/task.dart';
import 'storage_service.dart';

/// Manages all task-related operations and business logic
class TaskService {
  final StorageService _storageService = StorageService();
  List<Task> _tasks = [];

  /// Returns all tasks currently in memory
  List<Task> get tasks => _tasks;

  /// Loads tasks from storage into memory
  Future<void> loadTasks() async {
    _tasks = await _storageService.loadTasks();
  }

  /// Adds a new task and saves to storage
  Future<void> addTask(Task task) async {
    _tasks.add(task);
    await _storageService.saveTasks(_tasks);
  }

  /// Updates an existing task and saves to storage
  Future<void> updateTask(Task updatedTask) async {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      await _storageService.saveTasks(_tasks);
    }
  }

  /// Removes a task and saves to storage
  Future<void> deleteTask(String taskId) async {
    _tasks.removeWhere((task) => task.id == taskId);
    await _storageService.saveTasks(_tasks);
  }

  /// Gets all tasks for a specific date
  List<Task> getTasksForDate(DateTime date) {
    return _tasks.where((task) {
      return task.dueDate.year == date.year &&
          task.dueDate.month == date.month &&
          task.dueDate.day == date.day;
    }).toList();
  }

  /// Gets tasks due today
  List<Task> getTodayTasks() {
    final today = DateTime.now();
    return getTasksForDate(today);
  }

  /// Gets tasks with pending reminders (within last hour)
  List<Task> getPendingReminders() {
    final now = DateTime.now();
    return _tasks.where((task) {
      return task.reminderTime != null &&
          !task.isCompleted &&
          task.reminderTime!.isBefore(now) &&
          task.reminderTime!.isAfter(now.subtract(const Duration(hours: 1)));
    }).toList();
  }
}
