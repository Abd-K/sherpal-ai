import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sherpal/models/goals_provider_model.dart';
import 'package:sherpal/models/goal_model.dart';
import 'package:sherpal/views/Goals/goal_view.dart';
import 'package:intl/intl.dart';

class ThisWeekView extends StatefulWidget {
  const ThisWeekView({super.key});

  @override
  State<ThisWeekView> createState() => _ThisWeekViewState();
}

class _ThisWeekViewState extends State<ThisWeekView> {
  bool _isLoading = true;
  List<Goal> _thisWeekGoals = [];

  @override
  void initState() {
    super.initState();
    _loadThisWeekGoals();
  }

  Future<void> _loadThisWeekGoals() async {
    setState(() {
      _isLoading = true;
    });
    
    final goalsProvider = Provider.of<GoalsProvider>(context, listen: false);
    final allGoals = await goalsProvider.loadGoals();
    
    // Filter goals for this week
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));
    
    _thisWeekGoals = allGoals.where((goal) {
      if (goal.deadline == null) return false;
      
      try {
        final deadline = DateTime.parse(goal.deadline!);
        return deadline.isAfter(startOfWeek) && 
               deadline.isBefore(endOfWeek.add(Duration(days: 1)));
      } catch (e) {
        return false;
      }
    }).toList();
    
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _thisWeekGoals.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No goals for this week',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Create goals with deadlines this week to see them here',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.only(top: 240, right: 16, left: 16, bottom: 140),
                  shrinkWrap: true,
                  itemCount: _thisWeekGoals.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    final goal = _thisWeekGoals[index];
                    // Calculate progress percentage
                    double progressPercentage = 0.0;
                    if (goal.measurementType == 'checkbox') {
                      progressPercentage = goal.isCompleted ? 1.0 : 0.0;
                    } else if (goal.targetValue != null && goal.currentValue != null) {
                      try {
                        double target = double.parse(goal.targetValue!);
                        double current = double.parse(goal.currentValue!);
                        if (target > 0) {
                          progressPercentage = (current / target).clamp(0.0, 1.0);
                        }
                      } catch (e) {
                        // Handle parsing errors
                        progressPercentage = 0.0;
                      }
                    }
                    
                    // Format deadline
                    String deadlineText = 'No deadline';
                    if (goal.deadline != null) {
                      try {
                        final deadline = DateTime.parse(goal.deadline!);
                        deadlineText = DateFormat('E, MMM d').format(deadline);
                      } catch (e) {
                        // Use default if parsing fails
                      }
                    }
                    
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoalScreen(goalId: goal.id!),
                          ),
                        ).then((_) {
                          _loadThisWeekGoals(); // Reload goals when returning from goal details
                        });
                      },
                      child: Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 200,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade100)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      goal.title,
                                      style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.w500),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  if (goal.isCompleted)
                                    Icon(Icons.check_circle, color: Colors.green, size: 16),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                deadlineText,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 4),
                              if (goal.description.isNotEmpty)
                                Expanded(
                                  child: Text(
                                    goal.description,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              Spacer(),
                              Center(
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                              width: 5,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          child: CircularProgressIndicator(
                                            value: progressPercentage,
                                            strokeWidth: 5,
                                            backgroundColor: Colors.transparent,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              Colors.green.shade500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          '${(progressPercentage * 100).toInt()}%',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
