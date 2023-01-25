import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app/authorization/components/manual_button.dart';
import 'package:music_app/authorization/dashboboard/profile/view/profile_page.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _UploadMusicState();
}

class _UploadMusicState extends State<EditProfile> {
  TextEditingController eCont = TextEditingController();
  TextEditingController nCont = TextEditingController();
  PlatformFile? pickedFile;
  // ignore: non_constant_identifier_names
  String? image_url;
  String imageUrl = '';
  bool loading = false;

  Future getData() async {
    await FirebaseFirestore.instance
        .collection('user_details')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          nCont.text = snapshot.data()!['name'];
          eCont.text = snapshot.data()!['email'];
          image_url = snapshot.data()!['image'];
        });
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

// update data to fireStore database
  Future updateData() async {
    Map<String, String> dataToSend = {
      'name': nCont.text,
      'email': eCont.text,
      'image': imageUrl,
    };
    FirebaseFirestore.instance
        .collection('user_details')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(dataToSend);

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

  void selectImage() async {
    FilePickerResult? pickImage = await FilePicker.platform.pickFiles();
    if (pickImage == null) return;
    setState(() {
      pickedFile = pickImage.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Align(alignment: Alignment.center),
            pickedFile == null
                ? CircleAvatar(
                    radius: 70, backgroundImage: NetworkImage(image_url ?? ""))
                : CircleAvatar(
                    radius: 70,
                    backgroundImage: FileImage(File(pickedFile!.path!)),
                  ),
            InkWell(
                onTap: () {
                  selectImage();
                },
                child: const Icon(Icons.add_a_photo)),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: nCont,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: eCont,
              ),
            ),
            const SizedBox(height: 250),
            // OutlinedButton(
            //     onPressed: () async {
            //       updateData();
            //       // ScaffoldMessenger.of(context)
            //       //     .showSnackBar(SnackBar(content: Text("updated")));
            //     },
            //     child: const Text('Update Profle')),
            ManualButton(
              loading: loading,
              buttonName: 'Update Profile',
              onPress: () async {
                setState(() {
                  loading = true;
                });

                try {
                  await updateData();

                  // ignore: use_build_context_synchronously
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const ProfilePage();
                    },
                  ));
                } on FirebaseAuthException catch (e) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(content: Text(e.message.toString()));
                    },
                  );
                  setState(() {
                    loading = false;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
