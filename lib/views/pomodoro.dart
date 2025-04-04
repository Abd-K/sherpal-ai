import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sherpal/constants.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  bool isPaused = false; // Track if the timer is paused
  bool isRunning = false; // Track if the timer is running
  bool isFinished = false; // Track if the timer has finished
  int _remainingTime = 25 * 60; // 25 minutes in seconds
  Timer? _timer;
  final int _totalTime = 25 * 60; // Total time in seconds
  final Color _startColor = Colors.white;
  final Color _progressColor = Colors.green;
  final Color _endColor = Colors.indigo;
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  void _startTimer() {
    if (isRunning) return; // Prevent multiple timers

    setState(() {
      isRunning = true;
      isPaused = false;
      isFinished = false; // Reset finished state
    });

    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_remainingTime == 0) {
          _player.play(AssetSource('finish.mp3'));
          setState(() {
            timer.cancel();
            isRunning = false;
            isFinished = true;
            _remainingTime = _totalTime;
          });
        } else {
          setState(() {
            _remainingTime--;
          });
        }
      },
    );
  }

  void _pauseTimer() {
    if (isRunning) {
      _timer?.cancel();
      setState(() {
        isRunning = false;
        isPaused = true;
      });
    }
  }

  void _continueTimer() {
    if (isPaused) {
      _startTimer();
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _remainingTime = _totalTime;
      isRunning = false;
      isPaused = false;
      isFinished = false; // Reset finished state
    });
  }

  String _formatTime(int seconds) {
    int minutes = (seconds / 60).floor();
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 24, right: 24),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text(
                'Cracking Coding interview',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              )),
            ),
            const SizedBox(
              height: 48,
            ),
            // Timer with Custom Border
            SizedBox(
              width: (MediaQuery.of(context).size.width) - 100,
              height: (MediaQuery.of(context).size.width) - 100,
              child: CustomPaint(
                painter: CircleBorderPainter(
                  progress: 1.0 - (_remainingTime / _totalTime),
                  startColor: _startColor,
                  progressColor: _progressColor,
                  endColor: _endColor,
                  isFinished: isFinished,
                ),
                child: Center(
                  child: Text(
                    _formatTime(_remainingTime),
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            // Start/Resume Button
            GestureDetector(
              onTap: () {
                if (isPaused) {
                  _continueTimer(); // Continue if paused
                } else {
                  _startTimer(); // Start if not running
                }
              },
              child: Container(
                width: 150,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                    child: Text(
                  isPaused ? 'Resume' : 'Start',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                )),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            // Stop/Reset Button
            GestureDetector(
              onTap: () {
                if (isRunning || isPaused) {
                  if (isPaused) {
                    _resetTimer(); // Reset if paused
                  } else {
                    _pauseTimer(); // Pause if running
                  }
                }
              },
              child: Container(
                width: 150,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                    child: Text(
                  isPaused ? 'Reset' : 'Stop',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for the Circle Border
class CircleBorderPainter extends CustomPainter {
  final double progress; // Progress of the timer (0.0 to 1.0)
  final Color startColor;
  final Color progressColor;
  final Color endColor;
  final bool isFinished; // Whether the timer has finished

  CircleBorderPainter({
    required this.progress,
    required this.startColor,
    required this.progressColor,
    required this.endColor,
    required this.isFinished,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    // If the timer is finished, set the entire border to indigo
    if (isFinished) {
      paint.color = endColor;
      canvas.drawArc(
        rect,
        -0.5 * 3.14, // Start from the top (-90 degrees in radians)
        2 * 3.14, // Full circle
        false,
        paint,
      );
      return;
    }

    // Draw the initial white border
    paint.color = startColor;
    canvas.drawArc(
      rect,
      -0.5 * 3.14, // Start from the top (-90 degrees in radians)
      2 * 3.14, // Full circle
      false,
      paint,
    );

    // Draw the progress in green
    paint.color = progressColor;
    canvas.drawArc(
      rect,
      -0.5 * 3.14, // Start from the top (-90 degrees in radians)
      2 * 3.14 * progress, // Sweep angle based on progress
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CircleBorderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.isFinished != isFinished;
  }
}
