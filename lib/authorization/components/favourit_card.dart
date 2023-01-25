import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FavouritCard extends StatelessWidget {
  String cardImage;
  String cardTiltle;
  VoidCallback onTab;
  FavouritCard(
      {Key? key,
      required this.cardImage,
      required this.cardTiltle,
      required this.onTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: size.height * 0.17,
          width: size.height * 0.17,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Image.asset(
            cardImage,
            fit: BoxFit.fill,
          ),
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
      ],
    );
  }
}
