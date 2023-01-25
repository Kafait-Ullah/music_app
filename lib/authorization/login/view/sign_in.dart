import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_app/authorization/components/manual_button.dart';
import 'package:music_app/authorization/dashboboard/view/dashboard.dart';
import 'package:music_app/authorization/login/view/recover_password.dart';
import 'package:music_app/authorization/signup/view/register.dart';
import '../../components/constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _RegisterState();
}

class _RegisterState extends State<SignIn> {
  // final passwordValidator = MultiValidator([
  //   RequiredValidator(errorText: 'password is required'),
  //   MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  //   PatternValidator(r'(?=.*?[#?!@$%^&*-])',
  //       errorText: 'passwords must have at least one special character')
  // ]);

  TextEditingController eCont = TextEditingController();
  TextEditingController pCont = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String password;
  bool isPasswordShown = true;
  bool loading = false;
  String errorMessage = '';

  @override
  void dispose() {
    super.dispose();
    eCont.dispose();
    pCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.04, left: size.width * 0.05),
                child: Row(
                  children: [
                    Container(
                      height: size.height * 0.09,
                      width: size.width * 0.09,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_back_ios_new_outlined,
                              size: size.height * 0.018,
                              color: Colors.black54)),
                    ),
                    SizedBox(
                      width: size.width * 0.15,
                    ),
                    Image.asset('assets/images/logo.png',
                        height: size.height * 0.050),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              const Text('Sign In',
                  style: TextStyle(
                      fontFamily: 'Font',
                      color: Color(0xff383838),
                      fontWeight: FontWeight.bold,
                      fontSize: 26)),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                        textAlign: TextAlign.center,
                        'If You Need Any Support',
                        style: TextStyle(
                            fontFamily: 'Font',
                            color: cblack,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.04)),
                    InkWell(
                      onTap: () {},
                      child: Text(
                          textAlign: TextAlign.center,
                          'Click Here',
                          style: TextStyle(
                              fontFamily: 'Font',
                              color: const Color(0xff38B432),
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.04)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.01),
                child: TextFormField(
                  controller: eCont,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    height: 2,
                    color: Color(0xff474A56),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Color(0xffC8D1E1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Color(0xffC8D1E1),
                      ),
                    ),
                    hintText: "Enter Email",
                    hintStyle: const TextStyle(color: Color(0xffC8D1E1)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  validator: (value) {
                    if (!eCont.text.contains("@")) {
                      return 'Please enter valid password';
                    } else if (!eCont.text.contains(".com")) {
                      return 'Please enter valid password';
                    } else {
                      return null;
                    }
                  },
                  // validator: MultiValidator([
                  //   RequiredValidator(
                  //       errorText: 'Please enter some value'),
                  //   EmailValidator(
                  //       errorText:
                  //           'Entered email format is wrong.')
                  // ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.01),
                child: TextFormField(
                  controller: pCont,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: isPasswordShown,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(
                    height: 2,
                    color: Color(0xff474A56),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Color(0xffC8D1E1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Color(0xffC8D1E1),
                      ),
                    ),
                    hintText: "Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordShown = !isPasswordShown;
                          });
                        },
                        icon: isPasswordShown
                            ? const Icon(
                                FontAwesomeIcons.eyeSlash,
                                color: Color(0xff474A56),
                              )
                            : const Icon(
                                FontAwesomeIcons.eye,
                                color: Color(0xff474A56),
                              )),
                    hintStyle: const TextStyle(color: Color(0xffC8D1E1)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  validator: (value) {
                    if (pCont.text.length < 8) {
                      return 'Your password is less then 8 characters';
                    }
                    return null;
                  },
                  // onChanged: (val) => password = val,
                  // validator: passwordValidator,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.02, left: size.width * 0.05),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const RecovePassword();
                          },
                        ));
                      },
                      child: Text('Recovery Password',
                          style: TextStyle(
                              fontFamily: 'Font',
                              color: cblack,
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.045)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              ManualButton(
                loading: loading,
                buttonName: 'Sign In',
                onPress: () async {
                  setState(() {
                    loading = true;
                  });
                  if (_formKey.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: eCont.text, password: pCont.text)
                          .then((value) =>
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const DashBoard();
                                },
                              )));

                      errorMessage = '';
                      setState(() {
                        loading = false;
                      });
                    } on FirebaseAuthException catch (e) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              content: Text(e.message.toString()));
                        },
                      );
                      setState(() {
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              Row(children: <Widget>[
                Expanded(
                  child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: Divider(
                        color: Colors.black,
                        height: size.height * 0.03,
                      )),
                ),
                const Text("OR"),
                Expanded(
                  child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: Divider(
                        color: Colors.black,
                        height: size.height * 0.03,
                      )),
                ),
              ]),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/googlee.png'),
                    Image.asset('assets/images/apple.png')
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.19),
                child: Row(
                  children: [
                    Text(
                        textAlign: TextAlign.center,
                        'Not A Member?',
                        style: TextStyle(
                            fontFamily: 'Font',
                            color: cblack,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.04)),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Register(),
                            ));
                      },
                      child: Text(
                          textAlign: TextAlign.center,
                          ' Register Now',
                          style: TextStyle(
                              fontFamily: 'Font',
                              color: const Color(0xff288CE9),
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.04)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // saveLogin() {
  //   setState(() {
  //     loading = true;
  //   });
  //   if (_formKey.currentState!.validate()) {
  //     _auth
  //         .signInWithEmailAndPassword(
  //             email: eCont.text, password: pCont.text.toString())
  //         .then((value) {
  //       Utils().toastMessage(value.user!.email.toString());
  //       Navigator.push(context, MaterialPageRoute(
  //         builder: (context) {
  //           return DashBoard();
  //         },
  //       ));
  //       setState(() {
  //         loading = false;
  //       });
  //     }).onError((error, stackTrace) {
  //       debugPrint(error.toString());
  //       Utils().toastMessage(error.toString());
  //       setState(() {
  //         loading = false;
  //       });
  //     });

  //     // var user = _auth.currentUser?.uid;
  //     // if (user != null) {
  //     //   Navigator.pushNamed(context, SignIn().toString());
  //     // }
  //   }
  // }
}
