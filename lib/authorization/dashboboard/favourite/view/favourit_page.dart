import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_app/authorization/components/favourit_card.dart';
import 'package:music_app/authorization/dashboboard/view/dashboard.dart';
import 'package:music_app/authorization/components/constants.dart';

class FavouritPage extends StatelessWidget {
  const FavouritPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: size.height * 0.30,
                width: size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/favourit.png')),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60))),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.05,
                        top: size.height * 0.01,
                        right: size.width * 0.04,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: size.height * 0.09,
                            width: size.width * 0.09,
                            decoration: const BoxDecoration(
                              color: Colors.black26,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const DashBoard(),
                                      ));
                                },
                                icon: Icon(Icons.arrow_back_ios_new_outlined,
                                    size: size.height * 0.018,
                                    color: const Color(0xffF0F0F0))),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                FontAwesomeIcons.ellipsisVertical,
                                color: const Color(0xffF0F0F0),
                                size: size.width * 0.050,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                child: Text('Billie eilish',
                    style: TextStyle(
                        fontFamily: 'Font',
                        color: cblack,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.04)),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size.width * 0.02),
                child: Text(' 2 album , 67 track',
                    style: TextStyle(
                        fontFamily: 'Font',
                        color: cblack,
                        fontSize: size.width * 0.035)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.10),
                child: Text(
                    textAlign: TextAlign.center,
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Turpis adipiscing vestibulum orci enim, nascetur vitae ',
                    style: TextStyle(
                        fontFamily: 'Font',
                        color: cblack,
                        fontSize: size.width * 0.035)),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.07,
                    top: size.height * 0.02,
                    bottom: size.height * 0.02),
                child: Row(
                  children: [
                    Text('Albums',
                        style: TextStyle(
                            fontFamily: 'Font',
                            color: cblack,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.04)),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: size.height * 0.25,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(width: size.width * 0.05),
                        FavouritCard(
                          cardImage: 'assets/images/favcard 1.png',
                          cardTiltle: 'lilbubblegum',
                          onTab: () {
                            // Navigator.push(context, MaterialPageRoute(
                            //   builder: (context) {
                            //     return  MusicPage();
                            //   },
                            // ));
                          },
                        ),
                        SizedBox(width: size.width * 0.03),
                        FavouritCard(
                          cardImage: 'assets/images/favcard 2.png',
                          cardTiltle: 'Happier Than Ever',
                          onTab: () {
                            // Navigator.push(context, MaterialPageRoute(
                            //   builder: (context) {
                            //     return const MusicPage();
                            //   },
                            // ));
                          },
                        ),
                        SizedBox(width: size.width * 0.03),
                        FavouritCard(
                          cardImage: 'assets/images/card 1.png',
                          cardTiltle: 'lilbubblegum',
                          onTab: () {
                            // Navigator.push(context, MaterialPageRoute(
                            //   builder: (context) {
                            //     return const MusicPage();
                            //   },
                            // ));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Songs',
                        style: TextStyle(
                            fontFamily: 'Font',
                            color: cblack,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.05)),
                    const Text('See More',
                        style: TextStyle(
                            fontFamily: 'Font', color: cblack, fontSize: 14)),
                  ],
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    child: ListTile(
                      onTap: () {},
                      leading: InkWell(
                        onTap: () {},
                        child: Container(
                            height: size.height * 0.04,
                            width: size.height * 0.04,
                            decoration: const BoxDecoration(
                                color: Color(0xffE6E6E6),
                                shape: BoxShape.circle),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: Color(0xff555555),
                            )),
                      ),
                      title: Text('As It Was',
                          style: TextStyle(
                              fontFamily: 'Font',
                              color: cblack,
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.04)),
                      subtitle: Text(
                        'Harry Styles',
                        style: TextStyle(
                            fontFamily: 'Font',
                            color: cblack,
                            fontSize: size.width * 0.04),
                      ),
                      trailing: const Icon(
                        FontAwesomeIcons.heart,
                        color: Color(0xffB4B4B4),
                      ),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
