import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:music_app/authorization/components/manual_button.dart';
import 'package:music_app/authorization/signup/view/register_signin.dart';
import 'package:music_app/authorization/components/constants.dart';

class ChooseMode extends StatefulWidget {
  const ChooseMode({super.key});

  @override
  State<ChooseMode> createState() => _ChooseModeState();
}

class _ChooseModeState extends State<ChooseMode> {
  bool isMaterial = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/choosemode.png'))),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png'),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.40),
            Container(
              alignment: Alignment.center,
              child: const Text('Choose Mode',
                  style: TextStyle(
                      fontFamily: 'Font',
                      color: cwhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            SizedBox(height: size.height * 0.030),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.grey[800], shape: BoxShape.circle),
                        ),
                        Center(
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  AdaptiveTheme.of(context).setDark();
                                });
                              },
                              icon: const Icon(
                                Icons.nightlight_outlined,
                                color: Colors.white,
                                size: 50,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.040),
                    const Text('Dark Mode',
                        style: TextStyle(
                            fontFamily: 'Font',
                            color: cwhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
                SizedBox(width: size.width * 0.10),
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.grey[800], shape: BoxShape.circle),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                AdaptiveTheme.of(context).setLight();
                              });
                            },
                            icon: const Icon(
                              Icons.light_mode,
                              color: Colors.white,
                              size: 50,
                            )),
                      ],
                    ),
                    SizedBox(height: size.height * 0.040),
                    const Text('Light Mode',
                        style: TextStyle(
                            fontFamily: 'Font',
                            color: cwhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
              ],
            ),
            SizedBox(height: size.height * 0.10),
            ManualButton(
              buttonName: 'Continue ',
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterSigin(),
                    ));
              },
            )
          ],
        ),
      ],
    ));
  }
}
