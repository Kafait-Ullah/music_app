import 'package:flutter/material.dart';
import 'package:music_app/authorization/components/constants.dart';

// ignore: must_be_immutable
class TabbarButton extends StatelessWidget {
  final String buttonName;
  VoidCallback onTap;
  bool isSelected;
   TabbarButton(
      {super.key,
      required this.buttonName,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.08),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          buttonName,
          style: TextStyle(
              fontSize: size.width * 0.05,
              fontFamily: 'Fonts',
              fontWeight: FontWeight.bold,
              color: isSelected ? cblack : cwhite),
        ),
      ),
    );
  }
}
