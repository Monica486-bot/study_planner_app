import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../services/task_service.dart';

class SettingsScreen extends StatefulWidget {
  final TaskService taskService;

  const SettingsScreen({super.key, required this.taskService});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final StorageService _storageService = StorageService();
  bool _remindersEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final enabled = await _storageService.getRemindersEnabled();
    setState(() {
      _remindersEnabled = enabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'App Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SwitchListTile(
            title: const Text('Enable Reminders'),
            subtitle: const Text('Show popup alerts for task reminders'),
            value: _remindersEnabled,
            onChanged: (value) async {
              await _storageService.setRemindersEnabled(value);
              setState(() {
                _remindersEnabled = value;
              });
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Storage Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text('Storage Method'),
            subtitle: const Text('SharedPreferences (JSON format)'),
            leading: const Icon(Icons.storage),
          ),
          ListTile(
            title: const Text('Total Tasks'),
            subtitle: Text('${widget.taskService.tasks.length} tasks stored'),
            leading: const Icon(Icons.task),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'App Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const ListTile(
            title: Text('App Version'),
            subtitle: Text('1.0.0'),
            leading: Icon(Icons.info),
          ),
          const ListTile(
            title: Text('Developer'),
            subtitle: Text('Study Planner Team'),
            leading: Icon(Icons.person),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About Study Planner',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'A Flutter-based study planner application that helps users manage their tasks, view them in a calendar format, and set reminders.',
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Features:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text('• Task Management with reminders'),
                    const Text('• Calendar view with task highlighting'),
                    const Text('• Local storage using SharedPreferences'),
                    const Text('• Clean Material Design interface'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
