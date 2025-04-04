import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sherpal/constants.dart';
import 'package:sherpal/navigation.dart';
import 'package:sherpal/widgets/custom_button.dart';
import 'package:sherpal/widgets/custom_textformfield.dart';
import 'package:sherpal/views/login_view.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  String username = '';
  String email = '';
  String password = '';
  bool obsucureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70),
                // ClipRRect(
                //   child: Image.asset(
                //     'assets/images/logo.png',
                //     width: 100,
                //     height: 100,
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to ',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.ruby),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Text('Email',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                SizedBox(
                  height: 12,
                ),
                CustomTextFormField(
                  controller: emailController,
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
                    username = value!;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Text('Username',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                SizedBox(
                  height: 12,
                ),
                CustomTextFormField(
                  controller: usernameController,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FaIcon(
                      FontAwesomeIcons.user,
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field Required';
                    }
                    return null;
                  },
                  hint: 'Username',
                  ontap: (value) {
                    email = value!;
                  },
                ),
                SizedBox(
                  height: 18,
                ),
                Text('Password',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                SizedBox(
                  height: 12,
                ),
                CustomTextFormField(
                  controller: passwordController,
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
                  obscureText: true,
                  hint: 'Password',
                  ontap: (value) {
                    password = value!;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                CustomButton(
                  ontap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                    );
                  },
                  formkey: formkey,
                  text: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.ruby),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                CustomButton(
                  gradient: AppColors.rubyHorizontalGradient,
                  // color: AppColors.ruby,
                  ontap: () {
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Navigation()),
                        (route) => false,
                      );
                    }
                  },
                  formkey: formkey,
                  text: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
