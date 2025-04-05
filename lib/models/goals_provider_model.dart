import 'package:flutter/material.dart';
import 'package:sherpal/models/database_model.dart';
import 'package:sherpal/models/goal_model.dart';

class GoalsProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper(); // Database helper instance
  List<Goal> _goals = []; // List to store goals
  List<Goal> _thisWeekGoals = []; // List to store this week's goals
  List<Goal> _sherpalGoals = []; // List to store Sherpal goals
  bool _isLoading = false; // Loading state

  // Getters
  List<Goal> get goals => _goals;
  List<Goal> get thisWeekGoals => _thisWeekGoals;
  List<Goal> get sherpalGoals => _sherpalGoals;
  bool get isLoading => _isLoading;

  // Load goals from the database (with optional category filter)
  Future<void> loadGoals({String? category}) async {
    _isLoading = true;
    notifyListeners();
    
    _goals = await _dbHelper.getGoals(category: category);
    
    _isLoading = false;
    notifyListeners();
  }

  // Load this week's goals
  Future<void> loadThisWeekGoals() async {
    _isLoading = true;
    notifyListeners();
    
    _thisWeekGoals = await _dbHelper.getThisWeekGoals();
    
    _isLoading = false;
    notifyListeners();
  }

  // Load Sherpal goals
  Future<void> loadSherpalGoals() async {
    _isLoading = true;
    notifyListeners();
    
    _sherpalGoals = await _dbHelper.getSherpalGoals();
    
    _isLoading = false;
    notifyListeners();
  }

  // Get objectives for a specific goal
  Future<List<Goal>> getObjectives(int parentId) async {
    return await _dbHelper.getObjectives(parentId);
  }

  // Get a specific goal by ID
  Future<Goal?> getGoal(int id) async {
    return await _dbHelper.getGoal(id);
  }

  // Add a new goal
  Future<void> addGoal(Goal goal) async {
    await _dbHelper.insertGoal(goal);
    await loadGoals();
    await loadThisWeekGoals();
    if (goal.category == 'sherpal') {
      await loadSherpalGoals();
    }
  }

  // Add a new objective to a goal
  Future<void> addObjective(Goal objective) async {
    await _dbHelper.insertGoal(objective);
    notifyListeners();
  }

  // Update an existing goal
  Future<void> updateGoal(Goal goal) async {
    await _dbHelper.updateGoal(goal);
    await loadGoals();
    await loadThisWeekGoals();
    if (goal.category == 'sherpal') {
      await loadSherpalGoals();
    }
  }

  // Delete a goal
  Future<void> deleteGoal(int id) async {
    await _dbHelper.deleteGoal(id);
    await loadGoals();
    await loadThisWeekGoals();
    await loadSherpalGoals();
  }

  // Update goal progress
  Future<void> updateGoalProgress(int id, String currentValue) async {
    await _dbHelper.updateGoalProgress(id, currentValue);
    await loadGoals();
    await loadThisWeekGoals();
    await loadSherpalGoals();
  }

  // Update best value
  Future<void> updateBestValue(int id, String bestValue) async {
    await _dbHelper.updateBestValue(id, bestValue);
    notifyListeners();
  }

  // Mark goal as completed
  Future<void> markGoalCompleted(int id, bool isCompleted) async {
    await _dbHelper.markGoalCompleted(id, isCompleted);
    await loadGoals();
    await loadThisWeekGoals();
    await loadSherpalGoals();
  }

  // Initialize all goals data
  Future<void> initializeGoals() async {
    await loadGoals();
    await loadThisWeekGoals();
    await loadSherpalGoals();
  }
}
