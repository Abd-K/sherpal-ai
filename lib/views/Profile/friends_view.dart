import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sherpal/constants.dart';
import 'package:sherpal/views/Profile/add_friend_view.dart';
import 'package:sherpal/widgets/custom_listview.dart';
import 'package:sherpal/widgets/smallcustomtextfield.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  bool show = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Friends',
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
                  shape: CircleBorder(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewFriend()),
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
            "Add Friend",
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
              hint: 'Search for friends',
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Friends',
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
                          value: 'challenge friend',
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8), // Set your own padding
                            child: Row(
                              children: [
                                FaIcon(FontAwesomeIcons.trophy),
                                SizedBox(width: 8),
                                Text('Challenge Friend'),
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          padding: EdgeInsets.zero,
                          value: 'remove',
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                FaIcon(FontAwesomeIcons.remove),
                                SizedBox(width: 16),
                                Text('Remove'),
                              ],
                            ),
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        switch (value) {
                          case 'challenge friend':
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ContactUs()),
                            // );
                            break;
                          case 'remove':
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => Account()),
                            // );
                            break;
                        }
                      },
                    ),
                    list: ['John Doe', 'John Doe', 'John Doe'],
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/boy.png'),
                          )),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
