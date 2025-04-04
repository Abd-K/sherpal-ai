import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sherpal/constants.dart';
import 'package:sherpal/navigation.dart';
import 'package:sherpal/widgets/custom_button.dart';
import 'package:sherpal/widgets/custom_textformfield.dart';
import 'package:sherpal/views/signup_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  String email = '';
  String password = '';
  bool obsucureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                        'Welcome Back to ',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Login',
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
                      email = value!;
                    },
                  ),
                  SizedBox(
                    height: 16,
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
                    obscureText: obsucureText,
                    hint: 'Password',
                    ontap: (value) {
                      password = value!;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                  CustomButton(
                    ontap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                        (route) => false,
                      );
                    },
                    formkey: formkey,
                    text: Text(
                      'Sign Up',
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
                    //color: AppColors.ruby,
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
                    text: Text('Login',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor)),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
