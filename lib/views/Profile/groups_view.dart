import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sherpal/constants.dart';
import 'package:sherpal/widgets/custom_listview.dart';
import 'package:sherpal/views/Profile/new_group.dart';
import 'package:sherpal/widgets/smallcustomtextfield.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  bool show = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Groups',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
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
                      MaterialPageRoute(builder: (context) => NewGroup()),
                    );
                  },
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            "Create Group",
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 32),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 32,
            ),
            SmallCustomTextField(
              hint: 'Search for groups',
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Groups',
                  style: TextStyle(
                      color: AppColors.ruby,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
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
                    color: AppColors.ruby,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            show
                ? CustomListViewVertical(
                    ellipsis: PopupMenuButton<String>(
                      menuPadding: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      position: PopupMenuPosition.under,
                      icon: FaIcon(
                        FontAwesomeIcons.ellipsisV,
                        color: AppColors.mediumGrey,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          padding: EdgeInsets.zero,
                          value: 'leave group',
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // SizedBox(width: 8),
                                  FaIcon(
                                    FontAwesomeIcons.remove,
                                    size: 16,
                                  ),
                                  SizedBox(width: 8),
                                  Text('Leave Group '),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                      onSelected: (value) {},
                    ),
                    list: ['John Doe', 'John Doe', 'John Doe'],
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.ruby),
                      child: Center(
                        child: Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
