# Study Planner App

A Flutter-based study planner application that helps users manage their tasks, view them in a calendar format, and set reminders.

## Features

### ✅ Task Management
- Create tasks with title (required), description (optional), due date (required), and reminder time (optional)
- View today's tasks on a dedicated screen
- View tasks for any selected date
- Edit existing tasks
- Mark tasks as completed
- Delete tasks with confirmation dialog

### 📅 Calendar View
- Monthly calendar displaying all days
- Visual highlighting of dates with tasks
- Tap any date to view tasks scheduled for that day
- Navigate between months

### ⏰ Reminder System
- Set reminder times for tasks
- Popup alerts when app is opened (simulated notifications)
- Toggle reminders on/off in settings

### 💾 Local Storage
- Tasks persist after app closure using SharedPreferences
- Data stored as JSON format
- Reliable data persistence

### 🧭 Navigation
- BottomNavigationBar with three screens:
  - **Today**: Shows tasks due today
  - **Calendar**: Monthly calendar with task view
  - **Settings**: App configuration and information

### ⚙️ Settings
- Toggle switch to enable/disable reminders
- Display storage method information (SharedPreferences)
- Show total number of stored tasks
- App version information

## Architecture

The app follows a clean architecture pattern with separation of concerns:

```
lib/
├── models/          # Data models
│   └── task.dart
├── services/        # Business logic and data services
│   ├── task_service.dart
│   └── storage_service.dart
├── screens/         # UI screens
│   ├── today_screen.dart
│   ├── calendar_screen.dart
│   ├── settings_screen.dart
│   ├── add_task_screen.dart
│   └── edit_task_screen.dart
├── widgets/         # Reusable UI components
│   └── task_tile.dart
└── main.dart        # App entry point
```

## Dependencies

- `flutter`: SDK
- `shared_preferences`: Local data storage
- `table_calendar`: Calendar widget
- `cupertino_icons`: iOS-style icons

## Getting Started

1. Ensure Flutter is installed on your system
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app

## Storage Implementation

The app uses **SharedPreferences** for local storage:
- Tasks are serialized to JSON format
- Settings (reminder preferences) are stored as boolean values
- Data persists across app sessions
- Simple and reliable for this use case

## UI/UX Design

- Follows Material Design principles
- Clean and intuitive interface
- Consistent use of Material widgets (Scaffold, AppBar, ListTile, Card)
- Responsive design that works in both portrait and landscape orientations
- Visual feedback for user interactions

## Key Widgets Used

- `Scaffold`: Main screen structure
- `BottomNavigationBar`: Navigation between screens
- `TableCalendar`: Monthly calendar display
- `ListView.builder`: Efficient list rendering
- `Card` & `ListTile`: Task display
- `FloatingActionButton`: Add task functionality
- `Form` & `TextFormField`: Task input
- `DatePicker` & `TimePicker`: Date/time selection
- `AlertDialog`: Confirmations and reminders
- `SwitchListTile`: Settings toggles

## Testing

The app has been tested on:
- Android emulator
- Physical Android devices
- Both portrait and landscape orientations
- App lifecycle events (background/foreground)

## Future Enhancements

- Task categories/tags
- Search and filter options
- Export/import functionality
- Background notifications
- Task priority levels
- Recurring tasks
