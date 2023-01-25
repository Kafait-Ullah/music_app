import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeCard extends StatelessWidget {
  String cardImage;
  String cardTiltle;
  String cardSubtitle;
  VoidCallback onTab;
  HomeCard(
      {Key? key,
      required this.cardImage,
      required this.cardSubtitle,
      required this.cardTiltle,
      required this.onTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: size.height * 0.22,
              width: size.height * 0.18,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Image.asset(cardImage),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                  height: size.height * 0.04,
                  width: size.height * 0.04,
                  decoration: const BoxDecoration(
                      color: Color(0xffE6E6E6), shape: BoxShape.circle),
                  child: InkWell(
                      onTap: onTab,
                      child: const Icon(Icons.play_arrow_rounded))),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.017, left: size.height * 0.010),
          child: Text(cardTiltle,
              style: TextStyle(
                  fontFamily: 'Font',
                  color: const Color(0xff383838),
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.018)),
        ),
        Padding(
          padding: EdgeInsets.only(left: size.height * 0.010),
          child: Text(cardSubtitle,
              style: TextStyle(
                  fontFamily: 'Font',
                  color: const Color(0xff383838),
                  fontSize: size.height * 0.017)),
        ),
      ],
    );
  }
}
