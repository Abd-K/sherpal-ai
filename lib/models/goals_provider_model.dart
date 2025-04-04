import 'package:flutter/material.dart';
import 'package:sherpal/models/database_model.dart';
import 'package:sherpal/models/goal_model.dart';

class GoalsProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper(); // Database helper instance
  List<Goal> _goals = []; // List to store goals

  // Getter for the list of goals
  List<Goal> get goals => _goals;

  // Load goals from the database (with optional category filter)
  Future<void> loadGoals({String? category}) async {
    _goals = await _dbHelper.getGoals(
        category: category); // Fetch goals from the database
    notifyListeners(); // Notify listeners to rebuild dependent widgets
  }

  // Add a new goal
  Future<void> addGoal(Goal goal) async {
    await _dbHelper.insertGoal(goal); // Insert the goal into the database
    await loadGoals(); // Reload goals to reflect the change
  }

  // Update an existing goal
  Future<void> updateGoal(Goal goal) async {
    await _dbHelper.updateGoal(goal); // Update the goal in the database
    await loadGoals(); // Reload goals to reflect the change
  }

  // Delete a goal
  Future<void> deleteGoal(int id) async {
    await _dbHelper.deleteGoal(id); // Delete the goal from the database
    await loadGoals(); // Reload goals to reflect the change
  }
}
