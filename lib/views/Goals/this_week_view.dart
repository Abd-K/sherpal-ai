import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sherpal/views/Goals/goal_view.dart';

class ThisWeekView extends StatefulWidget {
  const ThisWeekView({super.key});

  @override
  State<ThisWeekView> createState() => _ThisWeekViewState();
}

class _ThisWeekViewState extends State<ThisWeekView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: EdgeInsets.only(top: 240, right: 16, left: 16, bottom: 140),
        shrinkWrap: true,
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GoalScreen()));
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
                  children: [
                    Row(
                      children: [
                        Text(
                          'Job prep',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        FaIcon(FontAwesomeIcons.thumbtack),
                        SizedBox(
                          width: 8,
                        ),
                        FaIcon(FontAwesomeIcons.ellipsisVertical)
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.green.shade500, width: 5),
                      ),
                    )
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
