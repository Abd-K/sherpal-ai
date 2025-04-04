import 'package:flutter/material.dart';
import 'package:sherpal/constants.dart';
import 'package:sherpal/widgets/custom_button.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Us',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 32,
            ),
            Text(
              'Feedback or report an issue',
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
                hintText: 'Enter your message here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 8,
            ),
            SizedBox(
              height: 32,
            ),
            CustomButton(
              gradient: AppColors.rubyHorizontalGradient,
              text: Text(
                'Send',
                style: TextStyle(
                    fontSize: 18, color: Theme.of(context).primaryColor),
              ),
              ontap: () {},
              //color: AppColors.ruby,
            )
          ],
        ),
      ),
    );
  }
}
