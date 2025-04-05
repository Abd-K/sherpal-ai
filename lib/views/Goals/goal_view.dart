import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sherpal/constants.dart';
import 'package:sherpal/models/database_model.dart';
import 'package:sherpal/models/goal_model.dart';
import 'package:sherpal/models/goals_provider_model.dart';
import 'package:sherpal/views/Goals/new_goal_view.dart';
import 'package:sherpal/views/Goals/subgoal_view.dart';
import 'package:sherpal/views/Goals/timer_screen.dart';
import 'package:sherpal/widgets/custom_button.dart';
import 'package:sherpal/widgets/progress_tracking_widget.dart';

class GoalScreen extends StatefulWidget {
  final int goalId;
  
  const GoalScreen({super.key, required this.goalId});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  bool show = false;
  bool _isLoading = true;
  Goal? _goal;
  List<Goal> _objectives = [];
  final TextEditingController _progressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _loadGoalData();
  }
  
  @override
  void dispose() {
    _progressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  
  // Load goal data and objectives
  Future<void> _loadGoalData() async {
    setState(() {
      _isLoading = true;
    });
    
    final goalsProvider = Provider.of<GoalsProvider>(context, listen: false);
    
    // Load goal
    _goal = await goalsProvider.getGoal(widget.goalId);
    
    // Load objectives
    if (_goal != null) {
      _objectives = await goalsProvider.getObjectives(_goal!.id!);
      _descriptionController.text = _goal!.description;
      if (_goal!.currentValue != null) {
        _progressController.text = _goal!.currentValue!;
      }
    }
    
    setState(() {
      _isLoading = false;
    });
  }
  
  // Update goal progress
  void _updateProgress(String value) {
    if (_goal == null || value.isEmpty) return;
    
    Provider.of<GoalsProvider>(context, listen: false)
        .updateGoalProgress(_goal!.id!, value)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Progress updated')),
      );
      _loadGoalData(); // Reload data
    });
  }
  
  // Start timer for time-based goals
  void _startTimer() {
    if (_goal == null) return;
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TimerScreen(goalId: _goal!.id!),
      ),
    ).then((_) {
      _loadGoalData(); // Reload data when returning from timer screen
    });
  }
  
  // Update goal description
  void _updateDescription() {
    if (_goal == null) return;
    
    final updatedGoal = Goal(
      id: _goal!.id,
      title: _goal!.title,
      description: _descriptionController.text,
      deadline: _goal!.deadline,
      lastUpdated: DateTime.now().toIso8601String(),
      category: _goal!.category,
      goalType: _goal!.goalType,
      measurementType: _goal!.measurementType,
      targetValue: _goal!.targetValue,
      currentValue: _goal!.currentValue,
      parentId: _goal!.parentId,
      isCompleted: _goal!.isCompleted,
      bestValue: _goal!.bestValue,
    );
    
    Provider.of<GoalsProvider>(context, listen: false)
        .updateGoal(updatedGoal)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Goal updated')),
      );
      _loadGoalData(); // Reload data
    });
  }
  
  // Add new objective
  void _addObjective() {
    if (_goal == null) return;
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewGoal(parentId: _goal!.id),
      ),
    ).then((_) {
      _loadGoalData(); // Reload data when returning from objective creation
    });
  }
  
  // Navigate to objective details
  void _navigateToObjective(Goal objective) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubGoalScreen(objectiveId: objective.id!),
      ),
    ).then((_) {
      _loadGoalData(); // Reload data when returning from objective screen
    });
  }
  
  // Mark goal as completed
  void _toggleGoalCompletion() {
    if (_goal == null) return;
    
    Provider.of<GoalsProvider>(context, listen: false)
        .markGoalCompleted(_goal!.id!, !_goal!.isCompleted)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_goal!.isCompleted 
              ? 'Goal marked as incomplete' 
              : 'Goal marked as complete'),
        ),
      );
      _loadGoalData(); // Reload data
    });
  }
  
  // Build progress tracking widget
  Widget _buildProgressTracking() {
    if (_goal == null) return SizedBox();
    
    // If goal has objectives, don't show progress tracking
    if (_objectives.isNotEmpty) {
      return SizedBox();
    }
    
    return ProgressTrackingWidget(
      goal: _goal!,
      onProgressUpdate: _updateProgress,
      onTimerStart: _startTimer,
      progressController: _progressController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _goal?.title ?? 'Goal Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.check_circle_outline),
            onPressed: _goal != null ? _toggleGoalCompletion : null,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addObjective,
        backgroundColor: AppColors.ruby,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _goal == null
              ? Center(child: Text('Goal not found'))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 22),
                        Text(
                          'Target Date',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: _goal!.deadline != null
                                ? DateFormat('yyyy-MM-dd').format(
                                    DateTime.parse(_goal!.deadline))
                                : 'No deadline set',
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 9),
                              child: FaIcon(
                                FontAwesomeIcons.calendar,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: TextStyle(
                                  color: AppColors.ruby,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              TextField(
                                controller: _descriptionController,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: 'Enter description',
                                  hintStyle: TextStyle(color: Colors.grey[500]),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                onEditingComplete: _updateDescription,
                              ),
                              SizedBox(height: 8),
                              if (_objectives.isNotEmpty) ...[
                                SizedBox(height: 16),
                                Text(
                                  'Objectives',
                                  style: TextStyle(
                                    color: AppColors.ruby,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _objectives.length,
                                  itemBuilder: (context, index) {
                                    final objective = _objectives[index];
                                    return GestureDetector(
                                      onTap: () => _navigateToObjective(objective),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 6),
                                        child: Row(
                                          children: [
                                            Icon(
                                              objective.isCompleted
                                                  ? Icons.check_circle
                                                  : Icons.circle_outlined,
                                              size: 16,
                                              color: objective.isCompleted
                                                  ? AppColors.ruby
                                                  : Theme.of(context).cardColor,
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                objective.title,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  height: 1.2,
                                                  decoration: objective.isCompleted
                                                      ? TextDecoration.lineThrough
                                                      : null,
                                                ),
                                              ),
                                            ),
                                            Icon(
                                              Icons.chevron_right,
                                              color: Theme.of(context).cardColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        _buildProgressTracking(),
                        SizedBox(height: 16),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: show ? 280 : 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Advanced options',
                                      style: TextStyle(
                                        color: AppColors.ruby,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Spacer(),
                                    FaIcon(
                                      FontAwesomeIcons.pen,
                                      color: Theme.of(context).cardColor,
                                    ),
                                    SizedBox(width: 12),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          show = !show;
                                        });
                                      },
                                      child: FaIcon(
                                        show
                                            ? FontAwesomeIcons.chevronUp
                                            : FontAwesomeIcons.chevronDown,
                                        color: Theme.of(context).cardColor,
                                        size: 22,
                                      ),
                                    ),
                                  ],
                                ),
                                if (show) ...[
                                  SizedBox(height: 16),
                                  Text(
                                    'Goal Type',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  TextField(
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: _goal!.goalType != null
                                          ? _goal!.goalType!.substring(0, 1).toUpperCase() +
                                              _goal!.goalType!.substring(1)
                                          : 'Not set',
                                      hintStyle: TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16.0),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Measurement',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                            TextField(
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                hintText: _goal!.measurementType != null
                                                    ? _goal!.measurementType!.substring(0, 1).toUpperCase() +
                                                        _goal!.measurementType!.substring(1)
                                                    : 'Not set',
                                                hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(16.0),
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Target',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                            TextField(
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                hintText: _goal!.targetValue ?? 'Not set',
                                                hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(16.0),
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 80), // Space for FAB
                      ],
                    ),
                  ),
                ),
    );
  }
}
