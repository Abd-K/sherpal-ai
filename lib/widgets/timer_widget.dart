import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sherpal/constants.dart';

class TimerWidget extends StatefulWidget {
  final Function(int) onTimerComplete;
  final int targetMinutes;

  const TimerWidget({
    Key? key,
    required this.onTimerComplete,
    required this.targetMinutes,
  }) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? _timer;
  int _secondsElapsed = 0;
  bool _isRunning = false;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
      _isPaused = false;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });

      // Check if target time is reached
      if (_secondsElapsed >= widget.targetMinutes * 60) {
        _stopTimer();
        widget.onTimerComplete(_secondsElapsed ~/ 60);
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isPaused = true;
      _isRunning = false;
    });
  }

  void _resumeTimer() {
    _startTimer();
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isPaused = false;
    });
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _secondsElapsed = 0;
    });
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = secs.toString().padLeft(2, '0');

    return hours > 0 
        ? '$hoursStr:$minutesStr:$secondsStr' 
        : '$minutesStr:$secondsStr';
  }

  double get _progressValue {
    if (widget.targetMinutes <= 0) return 0;
    double progress = _secondsElapsed / (widget.targetMinutes * 60);
    return progress.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          Text(
            'Timer',
            style: TextStyle(
              color: AppColors.ruby,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 24),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: _progressValue,
                  strokeWidth: 12,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.ruby),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatTime(_secondsElapsed),
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.ruby,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Target: ${_formatTime(widget.targetMinutes * 60)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTimerButton(
                icon: Icons.play_arrow,
                label: 'Start',
                onPressed: !_isRunning && !_isPaused ? _startTimer : null,
                color: Colors.green,
              ),
              _buildTimerButton(
                icon: Icons.pause,
                label: 'Pause',
                onPressed: _isRunning ? _pauseTimer : null,
                color: AppColors.ruby,
              ),
              _buildTimerButton(
                icon: Icons.replay,
                label: 'Resume',
                onPressed: _isPaused ? _resumeTimer : null,
                color: Colors.blue,
              ),
              _buildTimerButton(
                icon: Icons.stop,
                label: 'Reset',
                onPressed: (_isRunning || _isPaused || _secondsElapsed > 0) ? _resetTimer : null,
                color: Colors.red,
              ),
            ],
          ),
          SizedBox(height: 16),
          if (_isRunning || _isPaused || _secondsElapsed > 0)
            ElevatedButton(
              onPressed: () {
                _stopTimer();
                widget.onTimerComplete(_secondsElapsed ~/ 60);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ruby,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Save Progress',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTimerButton({
    required IconData icon,
    required String label,
    required Function()? onPressed,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
          color: onPressed != null ? color : Colors.grey,
          iconSize: 32,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: onPressed != null ? color : Colors.grey,
          ),
        ),
      ],
    );
  }
}
