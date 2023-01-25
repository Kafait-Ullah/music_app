import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_app/authorization/dashboboard/favourite/view/favourit_page.dart';
import 'package:music_app/authorization/dashboboard/home/view/home_page.dart';
import 'package:music_app/authorization/dashboboard/profile/view/profile_page.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  List<IconData> bottomIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.music,
    FontAwesomeIcons.heart,
    FontAwesomeIcons.user,
  ];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          HomePage(),
          HomePage(),
          FavouritPage(),
          ProfilePage(),
        ],
        onPageChanged: (v) {
          setState(() {
            currentIndex = v;
          });
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        color: const Color(0xffFFFFFF),
        shape: const CircularNotchedRectangle(),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              bottomIcons.length,
              (index) => GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 1),
                        curve: Curves.linear);
                    setState(() {
                      currentIndex = 0;
                    });
                  },
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.01,
                              bottom: size.height * 0.01,
                              left: size.height * 0.025,
                              right: size.height * 0.025),
                          child: IconButton(
                              iconSize: size.width * 0.065,
                              visualDensity: VisualDensity.compact,
                              onPressed: null,
                              icon: Icon(bottomIcons[index],
                                  color: currentIndex == index
                                      ? const Color(0xff42C83C)
                                      : const Color(0xff808080))),
                        ),
                      ])),
            )),
      ),
    );
  }
}
