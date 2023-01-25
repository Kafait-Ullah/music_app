import 'package:flutter/material.dart';
import 'package:music_app/authorization/signup/view/register.dart';
import 'package:music_app/authorization/login/view/sign_in.dart';

import '../../components/constants.dart';

class RegisterSigin extends StatelessWidget {
  const RegisterSigin({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.04, left: size.width * 0.03),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          size: 20,
                          color: Colors.black54,
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.09),
            Align(
                alignment: Alignment.topCenter,
                child: Image.asset('assets/images/logo.png')),
            SizedBox(height: size.height * 0.07),
            const Text('Enjoy Listening To Music',
                style: TextStyle(
                    fontFamily: 'Font',
                    color: Color(0xff383838),
                    fontWeight: FontWeight.bold,
                    fontSize: 26)),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: const Text(
                  textAlign: TextAlign.center,
                  'Spotify is a proprietary Swedish audio streaming and media services provider ',
                  style: TextStyle(
                      fontFamily: 'Font',
                      color: cwhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 17)),
            ),
            SizedBox(height: size.height * 0.03),

            Stack(
              children: [
                Image.asset('assets/images/register.png'),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Register(),
                              ));
                        },
                        child: Container(
                            height: 70,
                            width: 160,
                            decoration: const BoxDecoration(
                                color: Color(0xff42C83C),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: const Center(
                                child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ))),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignIn(),
                              ));
                        },
                        child: const Center(
                            child: Text(
                          'Sign in',
                          style: TextStyle(
                              color: Color(0xff383838),
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Padding(
            //   padding: EdgeInsets.only(
            //       right: size.width * 0.27, top: size.height * 0.004),
            //   child: Container(
            //     height: size.height * 0.415,
            //     width: size.width * 0.820,
            //     decoration: const BoxDecoration(
            //         image: DecorationImage(
            //             image: AssetImage('assets/images/register.png'))),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
