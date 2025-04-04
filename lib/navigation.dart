// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:sherpal/constants.dart';
// import 'package:sherpal/views/Goals/goals_view.dart';
// import 'package:sherpal/views/Profile/profile_view.dart';

// class Navigation extends StatefulWidget {
//   const Navigation({super.key});

//   @override
//   State<Navigation> createState() => _NavigationState();
// }

// class _NavigationState extends State<Navigation> {
//   bool isprofile = false;
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         body: Stack(
//           children: [
//             isprofile ? ProfileView() : GolasView(),
//             Positioned(
//               top: MediaQuery.of(context).size.height - 110,
//               left: 50,
//               right: 50,
//               child: Container(
//                 height: 80,
//                 padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).cardColor,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           isprofile = false;
//                         });
//                       },
//                       child: Container(
//                         height: 70,
//                         width: 70,
//                         decoration: BoxDecoration(
//                           color:
//                               isprofile ? Colors.transparent : AppColors.ruby,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Center(
//                           child: FaIcon(
//                             FontAwesomeIcons.flag,
//                             color: Theme.of(context).primaryColor,
//                             size: 30,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     isprofile
//                         ? Container()
//                         : Text(
//                             'My Goals',
//                             style: TextStyle(
//                               color: Theme.of(context).primaryColor,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                     SizedBox(
//                       width: 12,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           isprofile = true;
//                         });
//                       },
//                       child: Container(
//                         height: 70,
//                         width: 70,
//                         decoration: BoxDecoration(
//                           color:
//                               isprofile ? AppColors.ruby : Colors.transparent,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Center(
//                           child: FaIcon(
//                             FontAwesomeIcons.user,
//                             size: 30,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     isprofile
//                         ? Text(
//                             'Profile',
//                             style: TextStyle(
//                               color: Theme.of(context).primaryColor,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           )
//                         : Container(),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sherpal/constants.dart';
import 'package:sherpal/views/Goals/goals_view.dart';
import 'package:sherpal/views/Profile/profile_view.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  bool isprofile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Your Content View (No animation)
          isprofile ? const ProfileView() : const GoalsView(),

          // Custom Tab Bar
          Positioned(
            top: MediaQuery.of(context).size.height - 110,
            left: 50,
            right: 50,
            child: Container(
              height: 80,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Goals Tab
                  GestureDetector(
                    onTap: () => setState(() => isprofile = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: isprofile ? Colors.transparent : AppColors.ruby,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.flag,
                          color: isprofile
                              ? AppColors.mediumGrey
                              : Theme.of(context).primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  isprofile
                      ? Container()
                      : Text(
                          'My Goals',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  const Spacer(),
                  // Profile Tab
                  GestureDetector(
                    onTap: () => setState(() => isprofile = true),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: isprofile ? AppColors.ruby : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.solidUser,
                          size: 30,
                          color: isprofile
                              ? Theme.of(context).primaryColor
                              : AppColors.mediumGrey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  isprofile
                      ? Text(
                          'Profile  ',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
