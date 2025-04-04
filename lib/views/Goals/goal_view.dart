import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sherpal/constants.dart';
import 'package:sherpal/views/Goals/subgoal_view.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  bool show = false;
  final List<String> tasks = [
    "Update CV",
    "Brush Up Coding Skills",
    "Just Another Space Filler",
    "Just Another Space Filler",
    "Just Another Space Filler",
    "Just Another Space Filler",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job Prep',
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
              TextField(
                decoration: InputDecoration(
                    hintText: 'Select Date',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child: FaIcon(
                        FontAwesomeIcons.calendar,
                      ),
                    )),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 230,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notes',
                      style: TextStyle(
                        color: AppColors.ruby,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Practice For Job interviews',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 6,
                                color: Theme.of(context).cardColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                tasks[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
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
                            'Advance options',
                            style: TextStyle(
                                color: AppColors.ruby,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
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
                      show
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 16,
                                ),
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
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Select Goal Type',
                                    hintStyle:
                                        TextStyle(color: Colors.grey[500]),
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
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Measurment',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Time (min)',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[500],
                                                  fontSize: 14),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                borderSide: BorderSide.none,
                                              ),
                                              suffixIcon: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 9,
                                                ),
                                                child: FaIcon(
                                                  FontAwesomeIcons.chevronDown,
                                                  size: 22,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              decoration: InputDecoration(
                                            hintText: 'Enter Target',
                                            hintStyle: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 14),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              borderSide: BorderSide.none,
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 450,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubGoalScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(right: 16),
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey.shade100,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                    ),
                                    color: Colors.blue.shade100),
                                child: Center(
                                  child: Text(
                                    '0',
                                    style: TextStyle(
                                      color: AppColors.mediumGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 190,
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "Build Simple Marketing Campaign: ",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "240 Min",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  maxLines: 2,
                                ),
                              ),
                              Spacer(),
                              PopupMenuButton<String>(
                                padding: EdgeInsets.zero,
                                position: PopupMenuPosition.under,
                                icon: FaIcon(FontAwesomeIcons.ellipsisVertical),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 'target this week',
                                    child: ListTile(
                                      leading: FaIcon(
                                        FontAwesomeIcons.solidEnvelope,
                                        color: AppColors.ruby,
                                      ),
                                      title: Text('Target This Week'),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'convert to goal',
                                    child: ListTile(
                                      leading: FaIcon(
                                        FontAwesomeIcons.gear,
                                        color: AppColors.ruby,
                                      ),
                                      title: Text('Convert To Goal'),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'log history',
                                    child: ListTile(
                                      leading: FaIcon(
                                        // ignore: deprecated_member_use
                                        FontAwesomeIcons.shieldAlt,
                                        color: AppColors.ruby,
                                      ),
                                      title: Text('Log History'),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: ListTile(
                                      leading: FaIcon(
                                        // ignore: deprecated_member_use
                                        FontAwesomeIcons.shieldAlt,
                                        color: AppColors.ruby,
                                      ),
                                      title: Text('Delete'),
                                    ),
                                  ),
                                ],
                                onSelected: (value) {
                                  //   switch (value) {
                                  //     case 'ContactUsPage':
                                  //       Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(builder: (context) => ContactUs()),
                                  //       );
                                  //       break;
                                  //     case 'AccountPage':
                                  //       Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(builder: (context) => Account()),
                                  //       );
                                  //       break;
                                  //     case 'PrivacySettingsPage':
                                  //       Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) => PrivacySettings()),
                                  //       );
                                  //       break;
                                  //   }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 16,
                      );
                    },
                    itemCount: 5,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade500),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.add, color: Colors.grey.shade500),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Add Objective',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
