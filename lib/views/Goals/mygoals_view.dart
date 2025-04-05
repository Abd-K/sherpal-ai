import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sherpal/models/goals_provider_model.dart';
import 'package:sherpal/models/goal_model.dart';
import 'package:sherpal/views/Goals/goal_view.dart';
import 'package:sherpal/views/Goals/new_goal_view.dart';

class MygoalsView extends StatefulWidget {
  const MygoalsView({super.key});

  @override
  State<MygoalsView> createState() => _MygoalsViewState();
}

class _MygoalsViewState extends State<MygoalsView> {
  bool _isLoading = true;
  List<Goal> _goals = [];

  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  Future<void> _loadGoals() async {
    setState(() {
      _isLoading = true;
    });
    
    final goalsProvider = Provider.of<GoalsProvider>(context, listen: false);
    _goals = await goalsProvider.loadGoals();
    
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewGoal()),
          ).then((_) {
            _loadGoals(); // Reload goals when returning from goal creation
          });
        },
        child: Icon(Icons.add),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _goals.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No goals yet',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Tap the + button to create a new goal',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.only(top: 240, right: 16, left: 16, bottom: 140),
                  shrinkWrap: true,
                  itemCount: _goals.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    final goal = _goals[index];
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
                    
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoalScreen(goalId: goal.id!),
                          ),
                        ).then((_) {
                          _loadGoals(); // Reload goals when returning from goal details
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
                              SizedBox(height: 8),
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
