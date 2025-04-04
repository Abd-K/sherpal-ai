import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SmallCustomTextField extends StatelessWidget {
  const SmallCustomTextField({
    super.key,
    required this.hint,
  });
  final String hint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.all(6),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10, top: 8),
            child: FaIcon(FontAwesomeIcons.search,
                size: 18, color: Colors.grey[500]),
          ),
        ),
      ),
    );
  }
}
