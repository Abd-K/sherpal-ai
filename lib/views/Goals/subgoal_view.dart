import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sherpal/constants.dart';
import 'package:sherpal/models/database_model.dart';
import 'package:sherpal/models/goal_model.dart';
import 'package:sherpal/models/goals_provider_model.dart';
import 'package:sherpal/views/Goals/new_goal_view.dart';
import 'package:sherpal/widgets/custom_button.dart';

class SubGoalScreen extends StatefulWidget {
  final int objectiveId;
  
  const SubGoalScreen({super.key, required this.objectiveId});

  @override
  State<SubGoalScreen> createState() => _SubGoalScreenState();
}

class _SubGoalScreenState extends State<SubGoalScreen> {
  bool show = false;
  bool _isLoading = true;
  Goal? _objective;
  List<Goal> _subObjectives = [];
  final TextEditingController _progressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _loadObjectiveData();
  }
  
  @override
  void dispose() {
    _progressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  
  // Load objective data and sub-objectives
  Future<void> _loadObjectiveData() async {
    setState(() {
      _isLoading = true;
    });
    
    final goalsProvider = Provider.of<GoalsProvider>(context, listen: false);
    
    // Load objective
    _objective = await goalsProvider.getGoal(widget.objectiveId);
    
    // Load sub-objectives
    if (_objective != null) {
      _subObjectives = await goalsProvider.getObjectives(_objective!.id!);
      _descriptionController.text = _objective!.description;
      if (_objective!.currentValue != null) {
        _progressController.text = _objective!.currentValue!;
      }
    }
    
    setState(() {
      _isLoading = false;
    });
  }
  
  // Update objective progress
  void _updateProgress() {
    if (_objective == null || _progressController.text.isEmpty) return;
    
    Provider.of<GoalsProvider>(context, listen: false)
        .updateGoalProgress(_objective!.id!, _progressController.text)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Progress updated')),
      );
      _loadObjectiveData(); // Reload data
    });
  }
  
  // Start timer for time-based objectives
  void _startTimer() {
    // This will be implemented in the timer functionality step
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Timer functionality coming soon')),
    );
  }
  
  // Update objective description
  void _updateDescription() {
    if (_objective == null) return;
    
    final updatedObjective = Goal(
      id: _objective!.id,
      title: _objective!.title,
      description: _descriptionController.text,
      deadline: _objective!.deadline,
      lastUpdated: DateTime.now().toIso8601String(),
      category: _objective!.category,
      goalType: _objective!.goalType,
      measurementType: _objective!.measurementType,
      targetValue: _objective!.targetValue,
      currentValue: _objective!.currentValue,
      parentId: _objective!.parentId,
      isCompleted: _objective!.isCompleted,
      bestValue: _objective!.bestValue,
    );
    
    Provider.of<GoalsProvider>(context, listen: false)
        .updateGoal(updatedObjective)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Objective updated')),
      );
      _loadObjectiveData(); // Reload data
    });
  }
  
  // Add new sub-objective
  void _addSubObjective() {
    if (_objective == null) return;
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewGoal(parentId: _objective!.id),
      ),
    ).then((_) {
      _loadObjectiveData(); // Reload data when returning from objective creation
    });
  }
  
  // Navigate to sub-objective details
  void _navigateToSubObjective(Goal subObjective) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubGoalScreen(objectiveId: subObjective.id!),
      ),
    ).then((_) {
      _loadObjectiveData(); // Reload data when returning from sub-objective screen
    });
  }
  
  // Mark objective as completed
  void _toggleObjectiveCompletion() {
    if (_objective == null) return;
    
    Provider.of<GoalsProvider>(context, listen: false)
        .markGoalCompleted(_objective!.id!, !_objective!.isCompleted)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_objective!.isCompleted 
              ? 'Objective marked as incomplete' 
              : 'Objective marked as complete'),
        ),
      );
      _loadObjectiveData(); // Reload data
    });
  }
  
  // Build progress tracking widget
  Widget _buildProgressTracking() {
    if (_objective == null) return SizedBox();
    
    // If objective has sub-objectives, don't show progress tracking
    if (_subObjectives.isNotEmpty) {
      return SizedBox();
    }
    
    // For time-based objectives
    if (_objective!.measurementType == DatabaseHelper.measurementTypeTime) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progress',
              style: TextStyle(
                color: AppColors.ruby,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _progressController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Current progress (minutes)',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _updateProgress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.ruby,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            CustomButton(
              gradient: AppColors.rubyHorizontalGradient,
              text: Text(
                'Start Timer',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ontap: _startTimer,
            ),
          ],
        ),
      );
    }
    
    // For checkbox objectives
    if (_objective!.measurementType == DatabaseHelper.measurementTypeCheckbox) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progress',
              style: TextStyle(
                color: AppColors.ruby,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            CheckboxListTile(
              title: Text('Mark as completed'),
              value: _objective!.isCompleted,
              onChanged: (value) {
                if (value != null) {
                  _toggleObjectiveCompletion();
                }
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      );
    }
    
    // For other measurement types (reps, weight, distance)
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress',
            style: TextStyle(
              color: AppColors.ruby,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _progressController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Current progress',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: _updateProgress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.ruby,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          if (_objective!.targetValue != null && _objective!.currentValue != null)
            LinearProgressIndicator(
              value: double.tryParse(_objective!.currentValue!) != null && 
                     double.tryParse(_objective!.targetValue!) != null
                  ? double.parse(_objective!.currentValue!) / double.parse(_objective!.targetValue!)
                  : 0,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.ruby),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _objective?.title ?? 'Objective Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.check_circle_outline),
            onPressed: _objective != null ? _toggleObjectiveCompletion : null,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSubObjective,
        backgroundColor: AppColors.ruby,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _objective == null
              ? Center(child: Text('Objective not found'))
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
                            hintText: _objective!.deadline != null
                                ? DateFormat('yyyy-MM-dd').format(
                                    DateTime.parse(_objective!.deadline))
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
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
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
                        SizedBox(height: 16),
                        if (_subObjectives.isNotEmpty) ...[
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
                                  'Sub-Objectives',
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
                                  itemCount: _subObjectives.length,
                                  itemBuilder: (context, index) {
                                    final subObjective = _subObjectives[index];
                                    return GestureDetector(
                                      onTap: () => _navigateToSubObjective(subObjective),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 6),
                                        child: Row(
                                          children: [
                                            Icon(
                                              subObjective.isCompleted
                                                  ? Icons.check_circle
                                                  : Icons.circle_outlined,
                                              size: 16,
                                              color: subObjective.isCompleted
                                                  ? AppColors.ruby
                                                  : Theme.of(context).cardColor,
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                subObjective.title,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  height: 1.2,
                                                  decoration: subObjective.isCompleted
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
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
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
                                      hintText: _objective!.goalType != null
                                          ? _objective!.goalType!.substring(0, 1).toUpperCase() +
                                              _objective!.goalType!.substring(1)
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
                                                hintText: _objective!.measurementType != null
                                                    ? _objective!.measurementType!.substring(0, 1).toUpperCase() +
                                                        _objective!.measurementType!.substring(1)
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
                                                hintText: _objective!.targetValue ?? 'Not set',
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
