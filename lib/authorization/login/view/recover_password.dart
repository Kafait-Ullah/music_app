import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app/authorization/components/manual_button.dart';
import '../../components/constants.dart';

class RecovePassword extends StatefulWidget {
  const RecovePassword({super.key});

  @override
  State<RecovePassword> createState() => _RegisterState();
}

class _RegisterState extends State<RecovePassword> {
  TextEditingController eCont = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String password;
  bool isPasswordShown = true;
  bool loading = false;
  String errorMessage = '';

  @override
  void dispose() {
    super.dispose();
    eCont.dispose();
  }

  Future passworedReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: eCont.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
              content: Text('Password reset link sent! Check Your email'));
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text(e.toString()));
        },
      );
    }
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
              SizedBox(height: size.height * 0.20),
              Text('Recover Password',
                  style: TextStyle(
                      fontFamily: 'Font',
                      color: const Color(0xff383838),
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.02)),
              SizedBox(height: size.height * 0.04),
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
                ),
              ),
              Center(child: Text(errorMessage)),
              SizedBox(height: size.height * 0.03),
              ManualButton(
                  loading: loading,
                  buttonName: 'Reset Password',
                  onPress: passworedReset),
            ],
          ),
        ),
      ),
    );
  }
}
