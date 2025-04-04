import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sherpal/constants.dart';
import 'package:sherpal/widgets/custom_button.dart';
import 'package:sherpal/widgets/custom_textformfield.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool isenabled = false;
  //TextEditingController emailController = TextEditingController();
  //TextEditingController passwordController = TextEditingController();
  String email = '';
  String password = '';
  bool obsucureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32,
              ),
              Text('Email',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                isenabled: isenabled,
                initialvalue: 'tony@gmail.com',
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FaIcon(
                    FontAwesomeIcons.envelope,
                    color: Colors.grey,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field Required';
                  }
                  return null;
                },
                hint: 'Email',
                ontap: (value) {
                  email = value!;
                },
              ),
              SizedBox(
                height: 16,
              ),
              Text('Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              SizedBox(
                height: 12,
              ),
              CustomTextFormField(
                isenabled: isenabled,
                initialvalue: '123456789',
                //controller: passwordController,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FaIcon(
                    FontAwesomeIcons.lock,
                    color: Colors.grey,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field Required';
                  }
                  return null;
                },
                suffixIcon: InkWell(
                    onTap: () {
                      obsucureText = !obsucureText;
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FaIcon(
                        obsucureText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        color: Colors.grey,
                      ),
                    )),
                obscureText: obsucureText,
                hint: 'Password',
                ontap: (value) {
                  password = value!;
                },
              ),
              SizedBox(
                height: 48,
              ),
              Text(
                'Leave Feedback',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 96,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Are You Sure?",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 16),
                                Text(
                                  "Are you sure you want to permanently delete your account?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.mediumGrey,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomButton(
                                      color: AppColors.ruby,
                                      width: 130,
                                      text: Text(
                                        'You Love Us',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      ontap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    SizedBox(width: 16),
                                    CustomButton(
                                      bordercolor: Colors.transparent,
                                      color: AppColors.mediumGrey,
                                      width: 80,
                                      text: Text(
                                        'Bye😔',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      ontap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    'Delete Account',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationThickness: 2.0,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 64,
              ),
              CustomButton(
                text: Text(
                  'Logout',
                  style: TextStyle(
                    color: AppColors.ruby,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ontap: () {},
              ),
              SizedBox(
                height: 16,
              ),
              CustomButton(
                //color: AppColors.ruby,
                gradient: AppColors.rubyHorizontalGradient,
                text: Text(
                  'Update',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ontap: () {
                  setState(
                    () {
                      isenabled = !isenabled;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
