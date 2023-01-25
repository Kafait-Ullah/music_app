import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ManualButton extends StatelessWidget {
  final bool loading;
  String buttonName = '';
  final VoidCallback? onPress;
  ManualButton(
      {super.key,
      required this.buttonName,
      this.onPress,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPress,
      child: Container(
          height: size.height * 0.11,
          width: size.width * 0.90,
          decoration: const BoxDecoration(
              color: Color(0xff42C83C),
              borderRadius: BorderRadius.all(Radius.circular(33))),
          child: Center(
              child: loading
                  ? const CircularProgressIndicator(
                      strokeWidth: 4,
                      color: Colors.white,
                    )
                  : Text(
                      buttonName,
                      style: TextStyle(
                          fontFamily: 'Font',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.height * 0.025),
                    ))),
    );
  }
}
