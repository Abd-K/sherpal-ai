import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherpal/models/goals_provider_model.dart';
import 'package:sherpal/views/splash_screen.dart';
import 'package:sherpal/themes/themes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          GoalsProvider()..loadGoals(), // Initialize and load goals
      child: MyApp(),
    ),
  );
  //final goalsProvider = Provider.of<GoalsProvider>(context);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final useDarkTheme = false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ignore: dead_code
      theme: useDarkTheme ? AppThemes.darkTheme : AppThemes.lightTheme,
      home: SplashScreen(),
    );
  }
}
