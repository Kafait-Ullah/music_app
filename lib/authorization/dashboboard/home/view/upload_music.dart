import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_app/authorization/components/manual_button.dart';
import 'package:music_app/authorization/dashboboard/view/dashboard.dart';

class UploadMusic extends StatefulWidget {
  const UploadMusic({super.key});

  @override
  State<UploadMusic> createState() => _UploadMusicState();
}

class _UploadMusicState extends State<UploadMusic> {
  TextEditingController singerNameCont = TextEditingController();
  TextEditingController musicNamepCont = TextEditingController();
  PlatformFile? pickedImage;
  PlatformFile? picedkMusic;
  bool loading = false;
  String imageUrl = '';
  String musicUrl = '';

  //Pick Image file using File picker
  void selectImage() async {
    //1 Pick file from gallery
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
      ],
    );
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
          'song_image/${pickedImage!.name}${DateTime.now().millisecondsSinceEpoch}');

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

  //Pick music file using File picker
  void selectMusic() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'mp3',
      ],
    );
    if (result != null) {
      picedkMusic = result.files.first;
      setState(() {});
    } else {
      // ignore: avoid_print
      print('Select Music');
    }
  }

  //Upload music in Firebase Storage
  Future uploadMusic() async {
    try {
      final storageRef = FirebaseStorage.instance.ref();

      final musicRef = storageRef.child(
          'music_file/${picedkMusic!.name}${DateTime.now().millisecondsSinceEpoch}');

      final uploasdTaskMusic = await musicRef.putFile(File(picedkMusic!.path!));

      musicUrl = await uploasdTaskMusic.ref.getDownloadURL();
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
  Future uploadMusicDetails() async {
    Map<String, String> dataToSend = {
      'singer_name': singerNameCont.text,
      'song_name': musicNamepCont.text,
      'music_url': musicUrl,
      'image_url': imageUrl,
    };
    FirebaseFirestore.instance
        .collection('music_details')
        .doc()
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
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Align(alignment: Alignment.center),
            Stack(
              children: [
                Container(
                  height: size.height * 0.20,
                  width: size.width * 0.45,
                  decoration: const BoxDecoration(color: Color(0xff42C83C)),
                  child: pickedImage == null
                      ? Image.asset('assets/images/profile.png')
                      : Image.file(fit: BoxFit.cover, File(pickedImage!.path!)),
                ),
                Positioned(
                  bottom: size.height * -0.01,
                  right: size.width * -0.02,
                  child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: const Icon(Icons.camera_alt_outlined)),
                )
              ],
            ),
            IconButton(
                onPressed: () {
                  selectMusic();
                },
                icon: const Icon(FontAwesomeIcons.file)),
            SizedBox(height: size.height * 0.05),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: singerNameCont,
                decoration: const InputDecoration(hintText: 'Singer Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                controller: musicNamepCont,
                decoration: const InputDecoration(hintText: 'Song Name'),
              ),
            ),
            const SizedBox(height: 250),
            ManualButton(
              loading: loading,
              buttonName: 'Upload Song',
              onPress: () async {
                setState(() {
                  loading = true;
                });
                await uploadImage();
                await uploadMusic();
                uploadMusicDetails();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const DashBoard();
                  },
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
