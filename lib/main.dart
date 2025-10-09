import 'package:flutter/material.dart';
import 'services/task_service.dart';
import 'services/storage_service.dart';
import 'screens/today_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/settings_screen.dart';

/// Entry point of the Study Planner application
void main() {
  runApp(const StudyPlannerApp());
}

/// Root widget of the Study Planner app
class StudyPlannerApp extends StatelessWidget {
  const StudyPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Planner',
      // Enhanced theme with better colors and typography
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 10, 43, 231), // Modern indigo
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        // Enhanced card theme
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        // Enhanced app bar theme
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
        // Enhanced floating action button theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 4,
        ),
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Main screen with bottom navigation and three tabs
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // Current selected tab
  late TaskService _taskService; // Manages tasks
  late StorageService _storageService; // Handles storage
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _initializeServices(); // Load data when app starts
  }

  /// Initialize services and load data
  Future<void> _initializeServices() async {
    _taskService = TaskService();
    _storageService = StorageService();

    // Load saved tasks from storage
    await _taskService.loadTasks();

    // Check for pending reminders
    await _checkReminders();

    // Update UI to show loaded content
    setState(() {
      _isLoading = false;
    });
  }

  /// Check for pending reminders and show popup if any
  Future<void> _checkReminders() async {
    final remindersEnabled = await _storageService.getRemindersEnabled();
    if (remindersEnabled) {
      final pendingReminders = _taskService.getPendingReminders();
      if (pendingReminders.isNotEmpty && mounted) {
        _showReminderDialog(pendingReminders);
      }
    }
  }

  /// Shows popup dialog with pending reminders
  void _showReminderDialog(List<dynamic> reminders) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Task Reminders'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('You have pending reminders:'),
            const SizedBox(height: 8),
            // List each reminder task
            ...reminders.map((task) => Text('• ${task.title}')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show enhanced loading screen while initializing
    if (_isLoading) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.1),
                Theme.of(context).colorScheme.surface,
              ],
            ),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text(
                  'Loading your tasks...',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Define the three main screens
    final screens = [
      TodayScreen(taskService: _taskService), // Tab 0: Today's tasks
      CalendarScreen(taskService: _taskService), // Tab 1: Calendar view
      SettingsScreen(taskService: _taskService), // Tab 2: App settings
    ];

    return Scaffold(
      // Use IndexedStack to preserve state when switching tabs
      body: IndexedStack(index: _currentIndex, children: screens),
      // Bottom navigation with three tabs
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Switch to selected tab
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: 'Today'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
