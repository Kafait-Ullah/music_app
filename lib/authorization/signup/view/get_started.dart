import 'package:flutter/material.dart';
import 'package:music_app/authorization/components/manual_button.dart';
import 'package:music_app/authorization/signup/view/choose_mode.dart';
import 'package:music_app/authorization/components/constants.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

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
                  image: AssetImage('assets/images/getstart.png'))),
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
              child: const Text('Enjoy listening to music',
                  style: TextStyle(
                      fontFamily: 'Font',
                      color: cwhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 26)),
            ),
            SizedBox(height: size.height * 0.02),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                  textAlign: TextAlign.center,
                  'Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit. Sagittis enim purus sed phasellus. Cursus ornare id scelerisque aliquam.',
                  style: TextStyle(
                      fontFamily: 'Font',
                      color: Color(0xff797979),
                      fontSize: 18)),
            ),
            SizedBox(height: size.height * 0.050),
            ManualButton(
              buttonName: 'Get Started',
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChooseMode()));
              },
            )
          ],
        ),
      ],
    ));
  }
}
