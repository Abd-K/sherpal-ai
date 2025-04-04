import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sherpal/widgets/custom_textformfield.dart';

class NewFriend extends StatefulWidget {
  const NewFriend({super.key});

  @override
  State<NewFriend> createState() => _NewFriendState();
}

class _NewFriendState extends State<NewFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Add Friend', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 22,
            ),
            CustomTextFormField(
              hint: 'Search for Friends',
              ontap: (p0) {},
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: FaIcon(FontAwesomeIcons.search),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/boy.png'),
                      fit: BoxFit.cover,
                    ),
                    color: Theme.of(context).canvasColor,
                  ),
                ),
                SizedBox(
                  width: 22,
                ),
                Text(
                  'Tony',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Container(
                  width: 90,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    'Add',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
