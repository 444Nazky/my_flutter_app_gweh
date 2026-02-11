# my_flutter_app_gweh

A modern Flutter task management application with a clean UI and intuitive navigation.

## 📱 Features

- **Dashboard View** - Overview of ongoing projects and tasks with progress tracking
- **Task Management** - Create, view, and manage pending and completed tasks
- **Swipe-to-Delete** - Swipe actions to delete tasks from the dashboard
- **Bottom Navigation** - Easy navigation between Dashboard, To-Do, History, and Profile
- **Custom FAB** - Floating action button with custom positioning

## 🏗️ Project Structure

```
lib/
├── main.dart                  # App entry point
├── utils/
│   └── colors.dart            # Shared color constants
├── pages/
│   ├── login_page.dart        # Login screen
│   ├── home_page.dart         # Main dashboard with navigation
│   ├── todo_page.dart         # To-Do list management
│   ├── history_page.dart      # Task history view
│   └── profile_page.dart      # User profile screen
└── widgets/
    ├── dashboard_view.dart    # Dashboard UI components
    ├── navbar.dart            # Bottom navigation bar
    ├── my_tasks.dart          # My tasks widget
    ├── pending.dart           # Pending tasks widget
    └── completed.dart         # Completed tasks widget
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.0+
- Dart SDK 3.0+

### Installation

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to launch the app

### Dependencies

- `flutter_slidable` ^3.1.0 - For swipe-to-delete functionality
- `flutter_lints` ^6.0.0 - Linting rules

## 🎨 Design System

- **Primary Color**: Purple (#6B4EFF)
- **Text Colors**: Dark (#1A1A1A), Light (#6B6B6B)
- **Default Padding**: 24px

## 🗄️ Database Recommendation

### Firebase Firestore (Recommended for Production)

For a task management app with real-time sync across devices, **Firebase Firestore** is the recommended database solution:

**Why Firestore?**
- **Real-Time Sync** - Updates push instantly to all connected clients
- **Offline Support** - Writes queue when offline, sync automatically when online
- **Scalability** - Auto-scales with your user base
- **Security Rules** - Built-in RBAC (Role-Based Access Control)

**Data Model Example:**
```
users/{userId}
  - role: "admin" | "input_user"
  - name: "John Doe"
  - email: "john@example.com"

tasks/{taskId}
  - title: "Fix AC"
  - status: "pending" | "completed"
  - createdBy: userId
  - createdAt: timestamp
  - assignedTo: userId (optional)
```

**Alternative: Local Storage**
- **Hive** - Fast local storage for offline-first apps
- **SQLite** - Traditional relational database for complex queries

## 📝 Changelog

### 2026-XX-XX
- Reduced FAB (Floating Action Button) offsetY from default to 20
- Fixed duplicate dependencies in pubspec.yaml
- Added flutter_slidable package for swipe-to-delete functionality
- Implemented custom CenterDockedLowered FAB location

## 📄 License

This project is licensed under the MIT License.

