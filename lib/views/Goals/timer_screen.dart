import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherpal/models/database_model.dart';
import 'package:sherpal/models/goal_model.dart';
import 'package:sherpal/models/goals_provider_model.dart';
import 'package:sherpal/widgets/timer_widget.dart';

class TimerScreen extends StatefulWidget {
  final int goalId;
  
  const TimerScreen({Key? key, required this.goalId}) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  bool _isLoading = true;
  Goal? _goal;
  int _targetMinutes = 30; // Default value
  
  @override
  void initState() {
    super.initState();
    _loadGoalData();
  }
  
  Future<void> _loadGoalData() async {
    setState(() {
      _isLoading = true;
    });
    
    final goalsProvider = Provider.of<GoalsProvider>(context, listen: false);
    _goal = await goalsProvider.getGoal(widget.goalId);
    
    if (_goal != null && _goal!.targetValue != null) {
      try {
        _targetMinutes = int.parse(_goal!.targetValue!);
      } catch (e) {
        // Use default if parsing fails
        _targetMinutes = 30;
      }
    }
    
    setState(() {
      _isLoading = false;
    });
  }
  
  void _handleTimerComplete(int minutes) {
    if (_goal == null) return;
    
    Provider.of<GoalsProvider>(context, listen: false)
        .updateGoalProgress(_goal!.id!, minutes.toString())
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Progress updated: $minutes minutes')),
      );
      
      // If current progress exceeds target, update best value
      if (_goal!.bestValue == null || 
          int.parse(_goal!.bestValue!) < minutes) {
        Provider.of<GoalsProvider>(context, listen: false)
            .updateBestValue(_goal!.id!, minutes.toString());
      }
      
      Navigator.pop(context); // Return to goal screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _goal?.title ?? 'Timer',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _goal == null
              ? Center(child: Text('Goal not found'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Track your time for this goal',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Target: $_targetMinutes minutes',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 24),
                      TimerWidget(
                        onTimerComplete: _handleTimerComplete,
                        targetMinutes: _targetMinutes,
                      ),
                      SizedBox(height: 16),
                      if (_goal!.bestValue != null)
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.emoji_events, color: Colors.amber),
                                SizedBox(width: 8),
                                Text(
                                  'Best time: ${_goal!.bestValue} minutes',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
    );
  }
}
