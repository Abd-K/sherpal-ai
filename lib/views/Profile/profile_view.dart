import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sherpal/constants.dart';
import 'package:sherpal/views/Profile/account.dart';
import 'package:sherpal/views/Profile/contactus.dart';
import 'package:sherpal/widgets/custom_listview.dart';
import 'package:sherpal/views/Profile/friends_view.dart';
import 'package:sherpal/views/Profile/groups_view.dart';
import 'package:sherpal/views/Profile/notification_view.dart';
import 'package:sherpal/views/Profile/privacy_settings.dart';
import 'package:sherpal/widgets/smallcustomtextfield.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController friendscontroller = TextEditingController();
  final TextEditingController groupscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Tony',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            PopupMenuButton<String>(
              position: PopupMenuPosition.under,
              icon: FaIcon(FontAwesomeIcons.gear),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'ContactUsPage',
                  child: ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.solidEnvelope,
                      color: AppColors.ruby,
                    ),
                    title: Text('Contact us'),
                  ),
                ),
                PopupMenuItem(
                  value: 'AccountPage',
                  child: ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.gear,
                      color: AppColors.ruby,
                    ),
                    title: Text('Account'),
                  ),
                ),
                PopupMenuItem(
                  value: 'PrivacySettingsPage',
                  child: ListTile(
                    leading: FaIcon(
                      // ignore: deprecated_member_use
                      FontAwesomeIcons.shieldAlt,
                      color: AppColors.ruby,
                    ),
                    title: Text('Privacy Settings'),
                  ),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 'ContactUsPage':
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactUs()),
                    );
                    break;
                  case 'AccountPage':
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Account()),
                    );
                    break;
                  case 'PrivacySettingsPage':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacySettings()),
                    );
                    break;
                }
              },
            ),
            SizedBox(width: 12),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationView()),
                  );
                },
                child: FaIcon(FontAwesomeIcons.bell)),
            SizedBox(width: 12),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/boy.png'),
                        fit: BoxFit.cover,
                      ),
                      color: Theme.of(context).canvasColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Tony Test 123456',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tony Account',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.mediumGrey),
                  ),
                  SizedBox(height: 22),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        color: AppColors.ruby,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        FaIcon(FontAwesomeIcons.trophy,
                            color: Colors.amber, size: 28),
                        SizedBox(width: 12),
                        Text(
                          'Goals Achieved',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '20',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 190,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Friends',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FriendsScreen()),
                                );
                              },
                              child: Text(
                                'View All',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mediumGrey,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 12),
                        SmallCustomTextField(
                          hint: 'Search for friends',
                        ),
                        SizedBox(height: 16),
                        CustomListViewHorizontal(
                          list: [
                            'Tony',
                            'Amir',
                            'Tony',
                            'Amir',
                            'Tony',
                            'Amir'
                          ],
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
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 190,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Groups',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GroupsScreen()),
                                );
                              },
                              child: Text(
                                'View All',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mediumGrey,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 12),
                        SmallCustomTextField(
                          hint: 'Search for groups',
                        ),
                        SizedBox(height: 16),
                        CustomListViewHorizontal(
                          list: [
                            'Tony',
                            'Amir',
                            'Tony',
                            'Amir',
                            'Tony',
                            'Amir'
                          ],
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
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 130,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sherpal Goals',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.mediumGrey,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          height: 60,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFD99B77),
                                  Color(0xFFF2D0A7),
                                  Color(0xFFD99B77),
                                ],
                                stops: [0.0, 0.5, 1.0],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )),
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  'Explore: ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'The world is your oyster',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text('0/5',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
