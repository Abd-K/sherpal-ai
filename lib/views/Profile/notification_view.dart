import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sherpal/constants.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            position: PopupMenuPosition.under,
            icon: FaIcon(FontAwesomeIcons.bars),
            itemBuilder: (context) => [
              PopupMenuItem(
                padding: EdgeInsets.symmetric(horizontal: 8),
                value: 'mark all',
                child: ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                  ),
                  title: Text('Mark All as Read'),
                ),
              ),
            ],
            onSelected: (value) {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.bell,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Group Request',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      '31-01-2025',
                      style: TextStyle(color: AppColors.mediumGrey),
                    ),
                    PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      position: PopupMenuPosition.under,
                      icon: FaIcon(FontAwesomeIcons.ellipsisVertical),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          value: 'mark',
                          child: ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.solidCircleCheck,
                            ),
                            title: Text('Mark as Read'),
                          ),
                        ),
                      ],
                      onSelected: (value) {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'tony have joined the app',
                  style: TextStyle(
                    color: AppColors.mediumGrey,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: AppColors.lightGrey,
            );
          },
        ),
      ),
    );
  }
}
