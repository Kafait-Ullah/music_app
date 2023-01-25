import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_app/authorization/components/tabbar_button.dart';
import 'package:music_app/authorization/dashboboard/home/view/upload_music.dart';
import 'package:music_app/authorization/dashboboard/music/view/music_page.dart';
import 'package:music_app/authorization/components/constants.dart';
import 'package:music_app/authorization/login/view/sign_in.dart';

import '../../../components/home_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List tabButtons = [
    ['News', true],
    ['Video', false],
    ['Artist', false],
    ['Podcast', false],
    ['Podcast', false],
    ['Podcast', false],
    ['Podcast', false],
  ];

  void buttonTabSelected(int index) {
    setState(() {
      for (int i = 0; i < tabButtons.length; i++) {
        tabButtons[i][1] = false;
      }
      tabButtons[index][1] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: ListView(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.04,
                  left: size.width * 0.02,
                  right: size.width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search_sharp,
                        color: const Color(0xff7D7D7D),
                        size: size.width * 0.099,
                      )),
                  Image.asset('assets/images/logo.png',
                      height: size.height * 0.050),
                  PopupMenuButton(
                    onSelected: (value) {},
                    itemBuilder: (BuildContext bc) {
                      return [
                        PopupMenuItem(
                          value: '/uplad',
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const UploadMusic();
                                  },
                                ));
                              },
                              child: const Text("Upload Music")),
                        ),
                        PopupMenuItem(
                          value: '/about',
                          child:
                              InkWell(onTap: () {}, child: const Text("About")),
                        ),
                        PopupMenuItem(
                          value: '/logout',
                          child: InkWell(
                              onTap: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const SignIn();
                                  },
                                ));
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.logout),
                                  SizedBox(width: size.width * 0.02),
                                  const Text('LogOut')
                                ],
                              )),
                        ),
                      ];
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Container(
                    height: size.height * 0.16,
                    width: size.width * 0.96,
                    decoration: BoxDecoration(
                        color: cgreen, borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 0.05),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('New Album',
                                  style: TextStyle(
                                      fontFamily: 'Font',
                                      color: cwhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.height * 0.017)),
                              Text('Happier Than',
                                  style: TextStyle(
                                      fontFamily: 'Font',
                                      color: cwhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.height * 0.023)),
                              Text('Ever',
                                  style: TextStyle(
                                      fontFamily: 'Font',
                                      color: cwhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.height * 0.022)),
                              Text('Billie Eilish',
                                  style: TextStyle(
                                      fontFamily: 'Font',
                                      color: cwhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.height * 0.017)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: size.width * 0.06,
                  child: const Image(
                    image: AssetImage('assets/images/home_con.png'),
                  ),
                )
              ],
            ),
            SizedBox(height: size.height * 0.03),
            SizedBox(
                height: size.height * 0.03,
                width: double.infinity,
                // color: Colors.red,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tabButtons.length,
                  itemBuilder: (context, index) {
                    return TabbarButton(
                        buttonName: tabButtons[index][0],
                        isSelected: tabButtons[index][1],
                        onTap: (() {
                          buttonTabSelected(index);
                        }));
                  },
                )),
            SizedBox(height: size.height * 0.03),
            SizedBox(
              height: size.height * 0.3,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: size.width * 0.05),
                  HomeCard(
                    cardImage: 'assets/images/card 1.png',
                    cardTiltle: 'Dad Guyy',
                    cardSubtitle: 'Billie Eilish',
                    onTab: () {
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) {
                      //     return const MusicPage();
                      //   },
                      // ));
                    },
                  ),
                  SizedBox(width: size.width * 0.03),
                  HomeCard(
                    cardImage: 'assets/images/card 2.png',
                    cardTiltle: 'Scorpion',
                    cardSubtitle: 'Drake',
                    onTab: () {
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) {
                      //     return const MusicPage();
                      //   },
                      // ));
                    },
                  ),
                  SizedBox(width: size.width * 0.03),
                  HomeCard(
                    cardImage: 'assets/images/card 1.png',
                    cardTiltle: 'Dad Guyy',
                    cardSubtitle: 'Billie Eilish',
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
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Playlist',
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
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('music_details')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    var allSongs = snapshot.data!.docs
                        .map((e) => e.data() as Map<String, dynamic>)
                        .toList();
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return MusicPage(
                                songData: allSongs,
                              );
                            },
                          ));
                        },
                        leading: Container(
                            height: size.height * 0.04,
                            width: size.height * 0.04,
                            decoration: const BoxDecoration(
                                color: Color(0xffE6E6E6),
                                shape: BoxShape.circle),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: Color(0xff555555),
                            )),
                        title: Text(doc['song_name'],
                            style: TextStyle(
                                fontFamily: 'Font',
                                color: cblack,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.04)),
                        subtitle: Text(
                          doc['singer_name'],
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
                );
              },
            )
          ],
        ),
      ],
    ));
  }
}
