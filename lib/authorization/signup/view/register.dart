import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_app/authorization/components/manual_button.dart';
import 'package:music_app/authorization/dashboboard/view/dashboard.dart';
import 'package:music_app/authorization/login/view/sign_in.dart';
import 'package:music_app/authorization/components/constants.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController eCont = TextEditingController();
  TextEditingController pCont = TextEditingController();
  TextEditingController nCont = TextEditingController();
  bool isPasswordShown = true;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';
  PlatformFile? pickedImage;
  String imageUrl = '';

  //Pick Image file using File picker
  void selectImage() async {
    //1 Pick file from gallery
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      //2 store it in variabele PlatformFile
      pickedImage = result.files.first;
      setState(() {});
    } else {
      // ignore: avoid_print
      print('Select Image');
    }
  }

  //Upload image in Firebase Storage
  Future uploadImage() async {
    try {
      //Create a refrence for storage
      final storageRef = FirebaseStorage.instance.ref();

      // Create a child reference, this is for the name of the file we are going to upload
      // imagesRef now points to "images"
      final imagesRef = storageRef.child(
          'profile/${pickedImage!.name}${DateTime.now().millisecondsSinceEpoch}');

      //upload image path by passing constructor of name pickedImage to instance of File  in putFile function
      final uploasdTaskImage =
          await imagesRef.putFile(File(pickedImage!.path!));

      //store image url address in variable
      imageUrl = await uploasdTaskImage.ref.getDownloadURL();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text(e.toString()));
        },
      );
      return null;
    }
  }

  //Upload details in FirebaseFirestore database
  Future uploadDetails() async {
    Map<String, String> dataToSend = {
      'name': nCont.text,
      'email': eCont.text,
      'image': imageUrl,
    };
    FirebaseFirestore.instance
        .collection('user_details')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(dataToSend);

    try {} catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.toString()),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    eCont.dispose();
    pCont.dispose();
    nCont.dispose();
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
              Stack(
                children: [
                  CircleAvatar(
                    radius: size.height * 0.06,
                    backgroundColor: Colors.grey[200],
                    child: ClipOval(
                      //3 Show file for preview
                      child: pickedImage == null
                          ? Image.asset('assets/images/profile.png')
                          : Image.file(
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                              File(pickedImage!.path!)),
                    ),
                  ),
                  Positioned(
                    bottom: size.height * -0.01,
                    right: size.width * -0.02,
                    child: IconButton(
                        onPressed: () {
                          selectImage();
                        },
                        icon: const Icon(
                          Icons.add_a_photo_rounded,
                          color: Color(0xff38B432),
                        )),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.01),
              Text('Register',
                  style: TextStyle(
                      fontFamily: 'Font',
                      color: const Color(0xff383838),
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.032)),
              SizedBox(height: size.height * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.16),
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
              SizedBox(height: size.height * 0.01),
              //Name Text Fiedd
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.01),
                child: TextFormField(
                  controller: nCont,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.name,
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
                    hintText: "Full Name",
                    hintStyle: const TextStyle(color: Color(0xffC8D1E1)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              //Email Text Field
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
                    if (value!.isEmpty) {
                      return 'Email is required';
                    }
                    String email =
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                    RegExp regexpp = RegExp(email);
                    if (!regexpp.hasMatch(value.toString())) {
                      return '''Your email formate is wrong''';
                    }
                    return null;
                  },
                ),
              ),
              //Password Text Field
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
                    if (pCont.text.length < 7) {
                      return 'Your password is less then 8 characters';
                    }
                    return null;
                  },
                  // onChanged: (val) => password = val,
                  // validator: passwordValidator,

                  //  validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Password is required';
                  //   }

                  //   String pattern = r'(?=.*?[#?!@$%^&*-])([a-zA-Z]).{8,}$';
                  //   RegExp regex = RegExp(pattern);
                  //   if (!regex.hasMatch(value.toString())) {
                  //     return '''Your password must be 8 characters\nincluding symbol, number and UpperCase''';
                  //   }
                  //   return null;
                  // },
                ),
              ),
              SizedBox(height: size.height * 0.02),
              ManualButton(
                loading: loading,
                buttonName: 'Creat Account',
                onPress: () async {
                  setState(() {
                    loading = true;
                  });
                  if (_formKey.currentState!.validate()) {
                    try {
                      //Auth
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: eCont.text, password: pCont.text)
                          .then((value) async {
                        if (FirebaseAuth.instance.currentUser != null) {
                          //uploadimage function to Storage
                          await uploadImage();
                          //upload Details in firebaseFirestore database
                          uploadDetails();

                          // ignore: use_build_context_synchronously
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const DashBoard();
                            },
                          ));
                        }
                      });

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
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.17),
                child: Row(
                  children: [
                    Text(
                        textAlign: TextAlign.center,
                        'Do you have an account?',
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
                              builder: (context) => const SignIn(),
                            ));
                      },
                      child: Text(
                          textAlign: TextAlign.center,
                          ' Sign In',
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
}

// import 'dart:developer';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:music_app/authorization/dashboboard/view/dashboard.dart';

// class Register extends StatefulWidget {
//   const Register({super.key});
//   @override
//   State<Register> createState() => _UploadMusicState();
// }

// class _UploadMusicState extends State<Register> {
//   TextEditingController eCont = TextEditingController();
//   TextEditingController nCont = TextEditingController();
//   TextEditingController pCont = TextEditingController();
//   PlatformFile? pickedFile;

//   Future<String?> uploadFile() async {
//     try {
//       //Path for display name and date
//       final path =
//           'users/${pickedFile!.name}${DateTime.now().millisecondsSinceEpoch}';
//       //Refrence for storing data
//       final Reference reStorage = FirebaseStorage.instance.ref().child(path);
//       // > We cant assign string type in PutFile because return type is Sting so we add it in file variable and then inside File()
//       final file = File(pickedFile!.path!);
//       //Upload task after creating refrence and giving path name
//       final uploadTask = await reStorage.putFile(file);
//       return uploadTask.ref.getDownloadURL();
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }

//   void selectImage() async {
//     //1 Pick file from gallery
//     FilePickerResult? pickImage = await FilePicker.platform.pickFiles();
//     if (pickImage == null) return;
//     setState(() {
//       //2 store it in variabele PlatformFile
//       pickedFile = pickImage.files.first;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 60),
//             const Align(alignment: Alignment.center),
//             CircleAvatar(
//               radius: 70,
//               child: ClipOval(
//                 //3 Show file for preview
//                 child: pickedFile == null
//                     ? SizedBox.shrink()
//                     : Image.file(
//                         width: 150,
//                         height: 150,
//                         fit: BoxFit.cover,
//                         File(pickedFile!.path!)),
//               ),
//             ),
//             InkWell(
//                 onTap: () {
//                   selectImage();
//                 },
//                 child: const Icon(Icons.add_a_photo)),
//             const SizedBox(height: 30),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 50),
//               child: TextFormField(
//                 controller: nCont,
//                 decoration: const InputDecoration(hintText: 'Name'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 50),
//               child: TextFormField(
//                 keyboardType: TextInputType.emailAddress,
//                 controller: eCont,
//                 decoration: const InputDecoration(hintText: 'Email'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 50),
//               child: TextFormField(
//                 controller: pCont,
//                 decoration: const InputDecoration(hintText: 'Password'),
//               ),
//             ),
//             const SizedBox(height: 250),
//             OutlinedButton(
//                 onPressed: () async {
//                   try {
//                     //Create User Authentication
//                     UserCredential userCredential = await FirebaseAuth.instance
//                         .createUserWithEmailAndPassword(
//                             email: eCont.text.trim(),
//                             password: pCont.text.trim());
//                     //This function can upload pic
//                     var downloadUrl = await uploadFile();

//                     //Initilize firebaseFireStore and Create collection
//                     var fireStore =
//                         FirebaseFirestore.instance.collection('users');
//                     await fireStore
//                         .doc(FirebaseAuth.instance.currentUser!.uid)
//                         .set({
//                       "email": eCont.text,
//                       "name": nCont.text,
//                       "image_url": downloadUrl
//                     });
//                     // ignore: use_build_context_synchronously
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) {
//                         return const DashBoard();
//                       },
//                     ));
//                     // ScaffoldMessenger.of(context).showSnackBar(
//                     //     SnackBar(content: Text("Account created")));
//                   } on FirebaseAuthException catch (e) {
//                     if (e.code == 'weak-password') {
//                       print('The password provided is too weak.');
//                     } else if (e.code == 'email-already-in-use') {
//                       print('The account already exists for that email.');
//                     }
//                     log("Login error: ${e.toString()}");
//                   } catch (e) {
//                     log(e.toString());
//                   }
//                 },
//                 child: const Text('Register'))
//           ],
//         ),
//       ),
//     );
//   }
// }
