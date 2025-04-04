import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sherpal/constants.dart';
import 'package:sherpal/views/Goals/logs_view.dart';
import 'package:sherpal/views/Goals/mygoals_view.dart';
import 'package:sherpal/views/Goals/new_goal_view.dart';
import 'package:sherpal/views/Goals/sherpal_goals.dart';
import 'package:sherpal/views/Goals/this_week_view.dart';

class GoalsView extends StatefulWidget {
  const GoalsView({super.key});

  @override
  State<GoalsView> createState() => _GoalsViewState();
}

class _GoalsViewState extends State<GoalsView> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _selectedIndex == 0
              ? ThisWeekView()
              : _selectedIndex == 1
                  ? MygoalsView()
                  : SherpalGoals(),
          Positioned(
            right: 30,
            bottom: 140,
            child: Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.rubyHorizontalGradient,
              ),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewGoal()),
                  );
                },
                shape: CircleBorder(),
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).primaryColor,
                  weight: 30,
                  size: 32,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  gradient: AppColors.rubyHorizontalGradient),
            ),
          ),
          Positioned(
            top: 55,
            left: 30,
            child: Text(
              'Sherpal',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 55,
            right: 30,
            child: PopupMenuButton<String>(
              position: PopupMenuPosition.under,
              icon: FaIcon(FontAwesomeIcons.filter),
              itemBuilder: (context) {
                switch (_selectedIndex) {
                  case 0:
                    return [
                      PopupMenuItem(
                        value: 'log history',
                        child: ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.solidFileLines,
                          ),
                          title: Text('Log History'),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'challenge group',
                        child: ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.trophy,
                          ),
                          title: Text('Challenge Group'),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'challenge friend',
                        child: ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.trophy,
                          ),
                          title: Text('Challenge Friend'),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'remove target',
                        child: ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.remove,
                          ),
                          title: Text('Remove Target'),
                        ),
                      ),
                    ];
                  case 1:
                    return [
                      PopupMenuItem(
                        value: 'target this week',
                        child: ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.rocket,
                          ),
                          title: Text('Target This Week'),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'log history',
                        child: ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.solidFileLines,
                          ),
                          title: Text('Log History'),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'challenge group',
                        child: ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.trophy,
                          ),
                          title: Text('Challenge Group'),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'challenge friend',
                        child: ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.trophy,
                          ),
                          title: Text('Challenge Friend'),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'redeem rewards',
                        child: ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.boxOpen,
                          ),
                          title: Text('Redeem Rewards'),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'show hidden goals',
                        child: ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.solidEye,
                          ),
                          title: Text('Show Hidden Goals'),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.trash,
                          ),
                          title: Text('Delete'),
                        ),
                      ),
                    ];
                  default:
                    return [];
                }
              },
              onSelected: (value) {
                switch (value) {
                  case 'target this week':
                    // Action for target this week
                    break;
                  case 'log history':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogsScreen(),
                      ),
                    );
                    break;
                  // Add other cases as needed
                }
              },
            ),
          ),
          Positioned(
            top: 120,
            right: 30,
            left: 30,
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // First Tab
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    child: AnimatedContainer(
                      width: 80,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: _selectedIndex == 0
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.rocket,
                            color: _selectedIndex == 0
                                ? AppColors.ruby
                                : AppColors.mediumGrey,
                            size: 26,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'This Weak',
                            style: TextStyle(
                              color: _selectedIndex == 0
                                  ? AppColors.ruby
                                  : AppColors.mediumGrey,
                              fontSize: _selectedIndex == 0 ? 13 : 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '(6 days)',
                            style: TextStyle(
                              color: _selectedIndex == 0
                                  ? AppColors.ruby
                                  : AppColors.mediumGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Second Tab
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: AnimatedContainer(
                      width: 80,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: _selectedIndex == 1
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.solidFlag,
                            color: _selectedIndex == 1
                                ? AppColors.ruby
                                : AppColors.mediumGrey,
                            size: 30,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'My Goals',
                            style: TextStyle(
                              color: _selectedIndex == 1
                                  ? AppColors.ruby
                                  : AppColors.mediumGrey,
                              fontSize: _selectedIndex == 1 ? 14 : 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Third Tab
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                    child: AnimatedContainer(
                      width: 110,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _selectedIndex == 2
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.cubesStacked,
                            color: _selectedIndex == 2
                                ? AppColors.ruby
                                : AppColors.mediumGrey,
                            size: 30,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Sherpal Goals',
                            style: TextStyle(
                              color: _selectedIndex == 2
                                  ? AppColors.ruby
                                  : AppColors.mediumGrey,
                              fontSize: _selectedIndex == 2 ? 14 : 12,
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
          ),
        ],
      ),
    );
  }
}
