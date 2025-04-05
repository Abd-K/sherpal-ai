import 'package:flutter/material.dart';
import 'package:sherpal/constants.dart';
import 'package:sherpal/models/database_model.dart';
import 'package:sherpal/models/goal_model.dart';

class ProgressTrackingWidget extends StatelessWidget {
  final Goal goal;
  final Function(String) onProgressUpdate;
  final Function() onTimerStart;
  final TextEditingController progressController;

  const ProgressTrackingWidget({
    Key? key,
    required this.goal,
    required this.onProgressUpdate,
    required this.onTimerStart,
    required this.progressController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // For time-based goals
    if (goal.measurementType == DatabaseHelper.measurementTypeTime) {
      return _buildTimeBasedProgress(context);
    }
    
    // For checkbox goals
    if (goal.measurementType == DatabaseHelper.measurementTypeCheckbox) {
      return _buildCheckboxProgress(context);
    }
    
    // For other measurement types (reps, weight, distance)
    return _buildNumericProgress(context);
  }

  Widget _buildTimeBasedProgress(BuildContext context) {
    double progress = 0.0;
    if (goal.currentValue != null && goal.targetValue != null) {
      try {
        double current = double.parse(goal.currentValue!);
        double target = double.parse(goal.targetValue!);
        progress = current / target;
        // Clamp progress to 0.0-1.0 range
        progress = progress.clamp(0.0, 1.0);
      } catch (e) {
        // Handle parsing errors
        progress = 0.0;
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
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
                  controller: progressController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Current progress (minutes)',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => onProgressUpdate(progressController.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.ruby,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          _buildProgressCircle(context, progress),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onTimerStart,
            icon: Icon(Icons.timer, color: Colors.white),
            label: Text(
              'Start Timer',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.ruby,
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxProgress(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
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
          Container(
            decoration: BoxDecoration(
              color: goal.isCompleted ? AppColors.ruby.withOpacity(0.1) : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: CheckboxListTile(
              title: Text(
                'Mark as completed',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: goal.isCompleted ? AppColors.ruby : Colors.black87,
                ),
              ),
              value: goal.isCompleted,
              onChanged: (value) {
                if (value != null) {
                  onProgressUpdate(value ? "1" : "0");
                }
              },
              activeColor: AppColors.ruby,
              checkColor: Colors.white,
              controlAffinity: ListTileControlAffinity.leading,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: goal.isCompleted ? AppColors.ruby : Colors.grey[300],
              ),
              child: Center(
                child: Icon(
                  goal.isCompleted ? Icons.check : Icons.hourglass_empty,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumericProgress(BuildContext context) {
    double progress = 0.0;
    if (goal.currentValue != null && goal.targetValue != null) {
      try {
        double current = double.parse(goal.currentValue!);
        double target = double.parse(goal.targetValue!);
        progress = current / target;
        // Clamp progress to 0.0-1.0 range
        progress = progress.clamp(0.0, 1.0);
      } catch (e) {
        // Handle parsing errors
        progress = 0.0;
      }
    }

    String measurementLabel = '';
    switch (goal.measurementType) {
      case DatabaseHelper.measurementTypeReps:
        measurementLabel = 'reps';
        break;
      case DatabaseHelper.measurementTypeWeight:
        measurementLabel = 'kg';
        break;
      case DatabaseHelper.measurementTypeDistance:
        measurementLabel = 'km';
        break;
      default:
        measurementLabel = '';
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
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
                  controller: progressController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Current progress ($measurementLabel)',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => onProgressUpdate(progressController.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.ruby,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          _buildProgressCircle(context, progress),
          SizedBox(height: 16),
          if (goal.currentValue != null && goal.targetValue != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Current: ${goal.currentValue} $measurementLabel',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.ruby,
                    ),
                  ),
                  Text(
                    'Target: ${goal.targetValue} $measurementLabel',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProgressCircle(BuildContext context, double progress) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 12,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.ruby),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.ruby,
                ),
              ),
              Text(
                'Complete',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
