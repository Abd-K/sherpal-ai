# Sherpal Goals Feature - Integration Guide

This guide explains how to integrate the Goals feature implementation into your Sherpal-AI app.

## Overview

The Goals feature allows users to:
- Create goals with different types (work, fitness, general)
- Select measurement types based on goal type
- Set target values and deadlines
- Add objectives to goals (with infinite nesting)
- Track progress with visual indicators
- Use a timer for time-based goals

## Files Included

1. **Models**:
   - `database_model.dart` - Database schema and helper methods
   - `goal_model.dart` - Goal data model
   - `goals_provider_model.dart` - Provider for state management

2. **Views**:
   - `new_goal_view.dart` - Goal creation screen
   - `goal_view.dart` - Goal details and management
   - `subgoal_view.dart` - Objective details and management
   - `timer_screen.dart` - Timer for time-based goals

3. **Widgets**:
   - `progress_tracking_widget.dart` - Progress visualization
   - `timer_widget.dart` - Timer functionality

4. **Tests**:
   - `goals_test.dart` - Unit tests for the Goals feature

## Integration Steps

1. **Copy Files**:
   - Copy all the files from the zip to their respective locations in your project

2. **Update Dependencies**:
   - Ensure you have the following dependencies in your `pubspec.yaml`:
     ```yaml
     dependencies:
       provider: ^6.0.0
       intl: ^0.17.0
       sqflite: ^2.0.0+4
       path: ^1.8.0
       font_awesome_flutter: ^10.1.0
     ```

3. **Initialize Provider**:
   - In your `main.dart`, wrap your app with `ChangeNotifierProvider`:
     ```dart
     void main() {
       runApp(
         MultiProvider(
           providers: [
             ChangeNotifierProvider(create: (_) => GoalsProvider()),
             // Other providers...
           ],
           child: MyApp(),
         ),
       );
     }
     ```

4. **Initialize Database**:
   - Ensure the database is initialized at app startup:
     ```dart
     void main() async {
       WidgetsFlutterBinding.ensureInitialized();
       final dbHelper = DatabaseHelper();
       await dbHelper.database; // Initialize database
       
       // Rest of your app initialization...
     }
     ```

5. **Add Navigation**:
   - Add navigation to the Goals screens in your app's navigation system

## Usage Examples

### Loading Goals

```dart
// In your screen's initState or similar
final goalsProvider = Provider.of<GoalsProvider>(context, listen: false);
await goalsProvider.loadGoals();

// Access goals
final goals = goalsProvider.goals;
```

### Creating a Goal

```dart
final goal = Goal(
  title: 'My Goal',
  description: 'Description',
  deadline: DateTime.now().add(Duration(days: 7)).toIso8601String(),
  lastUpdated: DateTime.now().toIso8601String(),
  category: 'user',
  goalType: DatabaseHelper.goalTypeWork,
  measurementType: DatabaseHelper.measurementTypeTime,
  targetValue: '30', // 30 minutes
);

await Provider.of<GoalsProvider>(context, listen: false).addGoal(goal);
```

### Adding an Objective

```dart
final objective = Goal(
  title: 'My Objective',
  description: 'Description',
  deadline: DateTime.now().add(Duration(days: 7)).toIso8601String(),
  lastUpdated: DateTime.now().toIso8601String(),
  category: 'user',
  goalType: parentGoal.goalType,
  measurementType: DatabaseHelper.measurementTypeCheckbox,
  parentId: parentGoal.id, // Link to parent goal
);

await Provider.of<GoalsProvider>(context, listen: false).addObjective(objective);
```

### Updating Progress

```dart
await Provider.of<GoalsProvider>(context, listen: false)
    .updateGoalProgress(goalId, newProgressValue);
```

## Feature Details

### Goal Types
- **Work**: Supports time and checkbox measurements
- **Fitness**: Supports reps, weight, distance, time, and checkbox
- **General**: Supports checkbox

### Measurement Types
- **Time**: Track minutes spent on a goal
- **Checkbox**: Simple completion tracking
- **Reps**: Count repetitions
- **Weight**: Track weight lifted
- **Distance**: Track distance covered

### Timer Functionality
The timer feature provides:
- Start, pause, resume, and reset controls
- Visual progress indicator
- Automatic progress saving
- Best time tracking

## Customization

You can customize the appearance by modifying the widget files. The UI is designed to match the Figma designs provided, but you can adjust colors, sizes, and layouts as needed.

## Testing

Run the included tests to verify the implementation:

```
flutter test test/goals_test.dart
```

## Troubleshooting

- If database tables aren't created properly, ensure you're calling `DatabaseHelper().database` at app startup
- If UI doesn't match your theme, update the color constants in the widget files
- For any issues with the timer, check that the timer is properly disposed when navigating away from the screen
