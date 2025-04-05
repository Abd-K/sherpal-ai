import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sherpal/constants.dart';
import 'package:sherpal/models/database_model.dart';
import 'package:sherpal/models/goal_model.dart';
import 'package:sherpal/models/goals_provider_model.dart';
import 'package:sherpal/widgets/custom_button.dart';

class NewGoal extends StatefulWidget {
  final int? parentId; // For creating objectives
  
  const NewGoal({super.key, this.parentId});

  @override
  State<NewGoal> createState() => _NewGoalState();
}

class _NewGoalState extends State<NewGoal> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetController = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 7));
  String _selectedGoalType = DatabaseHelper.goalTypeWork;
  String _selectedMeasurementType = DatabaseHelper.measurementTypeTime;
  
  // Character count for title
  int _titleCharCount = 0;
  final int _maxTitleLength = 35;
  
  // Available measurement types based on goal type
  Map<String, List<String>> _measurementOptions = {
    DatabaseHelper.goalTypeWork: [
      DatabaseHelper.measurementTypeTime,
      DatabaseHelper.measurementTypeCheckbox,
    ],
    DatabaseHelper.goalTypeFitness: [
      DatabaseHelper.measurementTypeReps,
      DatabaseHelper.measurementTypeWeight,
      DatabaseHelper.measurementTypeDistance,
      DatabaseHelper.measurementTypeTime,
      DatabaseHelper.measurementTypeCheckbox,
    ],
    DatabaseHelper.goalTypeGeneral: [
      DatabaseHelper.measurementTypeCheckbox,
    ],
  };
  
  @override
  void initState() {
    super.initState();
    _titleController.addListener(_updateCharCount);
  }
  
  @override
  void dispose() {
    _titleController.removeListener(_updateCharCount);
    _titleController.dispose();
    _descriptionController.dispose();
    _targetController.dispose();
    super.dispose();
  }
  
  void _updateCharCount() {
    setState(() {
      _titleCharCount = _titleController.text.length;
    });
  }
  
  // Show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  
  // Show goal type selection dialog
  void _showGoalTypeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Goal Type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildGoalTypeOption(DatabaseHelper.goalTypeWork, 'Work'),
              _buildGoalTypeOption(DatabaseHelper.goalTypeFitness, 'Fitness'),
              _buildGoalTypeOption(DatabaseHelper.goalTypeGeneral, 'General'),
            ],
          ),
        );
      },
    );
  }
  
  // Build goal type option
  Widget _buildGoalTypeOption(String type, String label) {
    return ListTile(
      title: Text(label),
      selected: _selectedGoalType == type,
      onTap: () {
        setState(() {
          _selectedGoalType = type;
          // Reset measurement type to first available option for this goal type
          _selectedMeasurementType = _measurementOptions[type]![0];
        });
        Navigator.pop(context);
      },
    );
  }
  
  // Show measurement type selection dialog
  void _showMeasurementTypeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Measurement Type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _measurementOptions[_selectedGoalType]!.map((type) {
              return _buildMeasurementTypeOption(type);
            }).toList(),
          ),
        );
      },
    );
  }
  
  // Build measurement type option
  Widget _buildMeasurementTypeOption(String type) {
    String label;
    switch (type) {
      case DatabaseHelper.measurementTypeTime:
        label = 'Time (min)';
        break;
      case DatabaseHelper.measurementTypeCheckbox:
        label = 'Checkbox';
        break;
      case DatabaseHelper.measurementTypeReps:
        label = 'Reps';
        break;
      case DatabaseHelper.measurementTypeWeight:
        label = 'Weight (kg)';
        break;
      case DatabaseHelper.measurementTypeDistance:
        label = 'Distance (km)';
        break;
      default:
        label = type;
    }
    
    return ListTile(
      title: Text(label),
      selected: _selectedMeasurementType == type,
      onTap: () {
        setState(() {
          _selectedMeasurementType = type;
        });
        Navigator.pop(context);
      },
    );
  }
  
  // Get measurement type display text
  String _getMeasurementTypeText() {
    switch (_selectedMeasurementType) {
      case DatabaseHelper.measurementTypeTime:
        return 'Time (min)';
      case DatabaseHelper.measurementTypeCheckbox:
        return 'Checkbox';
      case DatabaseHelper.measurementTypeReps:
        return 'Reps';
      case DatabaseHelper.measurementTypeWeight:
        return 'Weight (kg)';
      case DatabaseHelper.measurementTypeDistance:
        return 'Distance (km)';
      default:
        return 'Select Measurement';
    }
  }
  
  // Get goal type display text
  String _getGoalTypeText() {
    switch (_selectedGoalType) {
      case DatabaseHelper.goalTypeWork:
        return 'Work';
      case DatabaseHelper.goalTypeFitness:
        return 'Fitness';
      case DatabaseHelper.goalTypeGeneral:
        return 'General';
      default:
        return 'Select Goal Type';
    }
  }
  
  // Create goal
  void _createGoal() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a goal title')),
      );
      return;
    }
    
    // Create goal object
    final goal = Goal(
      title: _titleController.text,
      description: _descriptionController.text,
      deadline: _selectedDate.toIso8601String(),
      lastUpdated: DateTime.now().toIso8601String(),
      category: 'user', // Default category
      goalType: _selectedGoalType,
      measurementType: _selectedMeasurementType,
      targetValue: _targetController.text,
      currentValue: '0', // Default starting value
      parentId: widget.parentId, // For objectives
    );
    
    // Save goal to database
    Provider.of<GoalsProvider>(context, listen: false).addGoal(goal).then((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Goal',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Text(
                    'Goal Title',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '$_titleCharCount/$_maxTitleLength',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mediumGrey),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: _titleController,
                maxLength: _maxTitleLength,
                decoration: InputDecoration(
                  hintText: 'Enter Goal Title',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none,
                  ),
                  counterText: '',
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Text(
                'Target Date',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: DateFormat('yyyy-MM-dd').format(_selectedDate),
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
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Goal Type',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () => _showGoalTypeDialog(context),
                        child: AbsorbPointer(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: _getGoalTypeText(),
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(top: 9),
                                child: FaIcon(
                                  FontAwesomeIcons.chevronDown,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
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
                                SizedBox(
                                  height: 16,
                                ),
                                GestureDetector(
                                  onTap: () => _showMeasurementTypeDialog(context),
                                  child: AbsorbPointer(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: _getMeasurementTypeText(),
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.only(top: 9),
                                          child: FaIcon(
                                            FontAwesomeIcons.chevronDown,
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
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
                                SizedBox(
                                  height: 16,
                                ),
                                TextField(
                                  controller: _targetController,
                                  keyboardType: _selectedMeasurementType == DatabaseHelper.measurementTypeCheckbox
                                      ? TextInputType.text
                                      : TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Target',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[500],
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
                          hintText: 'Enter Description',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              CustomButton(
                gradient: AppColors.rubyHorizontalGradient,
                text: Text(
                  'Create',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ontap: _createGoal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
