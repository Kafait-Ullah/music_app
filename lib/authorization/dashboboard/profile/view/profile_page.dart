import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_app/authorization/dashboboard/profile/view/edit_profile.dart';
import 'package:music_app/authorization/dashboboard/view/dashboard.dart';
import 'package:music_app/authorization/components/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name;
  String? email;
  String? imageUrl;
//get data from firestore database in variabels and pass them
  Future getData() async {
    await FirebaseFirestore.instance
        .collection('user_details')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!['name'];
          email = snapshot.data()!['email'];
          imageUrl = snapshot.data()!['image'];
        });
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: size.height * 0.42,
                width: size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60))),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.05,
                        top: size.height * 0.02,
                        right: size.width * 0.04,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: size.height * 0.09,
                            width: size.width * 0.09,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const DashBoard(),
                                      ));
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  size: size.height * 0.018,
                                  color: Colors.black54,
                                )),
                          ),
                          Text('Profile',
                              style: TextStyle(
                                  fontFamily: 'Font',
                                  color: cblack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.05)),
                          PopupMenuButton(
                            onSelected: (value) {
                              Navigator.pop(context);
                            },
                            itemBuilder: (BuildContext bc) {
                              return [
                                PopupMenuItem(
                                  value: '/edit',
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);

                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return const EditProfile();
                                        },
                                      ));
                                    },
                                    child: const Text("Edit profile"),
                                  ),
                                ),
                              ];
                            },
                          )
                        ],
                      ),
                    ),
                    CircleAvatar(
                        radius: size.height * 0.05,
                        backgroundImage: NetworkImage(imageUrl ?? "")),
                    SizedBox(height: size.height * 0.01),
                    Text(email ?? "",
                        style: TextStyle(
                            fontFamily: 'Font',
                            color: const Color(0xff222222),
                            fontSize: size.width * 0.04)),
                    SizedBox(height: size.height * 0.01),
                    Text(name ?? "",
                        style: TextStyle(
                            fontFamily: 'Font',
                            color: cblack,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.05)),
                    SizedBox(height: size.height * 0.02),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('778',
                                  style: TextStyle(
                                      fontFamily: 'Font',
                                      color: cblack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.05)),
                              Text('Followes',
                                  style: TextStyle(
                                      fontFamily: 'Font',
                                      color: const Color(0xff585858),
                                      fontSize: size.width * 0.04)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('243',
                                  style: TextStyle(
                                      fontFamily: 'Font',
                                      color: cblack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.05)),
                              Text('Followes',
                                  style: TextStyle(
                                      fontFamily: 'Font',
                                      color: const Color(0xff585858),
                                      fontSize: size.width * 0.04)),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.07, top: size.height * 0.02),
                child: Row(
                  children: [
                    Text('PUBLIC PLAYLISTS',
                        style: TextStyle(
                            fontFamily: 'Font',
                            color: cblack,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.04)),
                  ],
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                    ),
                    child: ListTile(
                        leading: InkWell(
                            onTap: () {},
                            child: Container(
                              height: size.height * 0.05,
                              width: size.width * 0.11,
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/card 1.png'),
                                ),
                              ),
                            )),
                        title: Text("Don't Smile At Me",
                            style: TextStyle(
                                fontFamily: 'Font',
                                color: cblack,
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.017)),
                        subtitle: Text(
                          'Billie Eilish',
                          style: TextStyle(
                              fontFamily: 'Font',
                              color: cblack,
                              fontSize: size.height * 0.017),
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.ellipsis,
                              color: const Color(0xff7D7D7D),
                              size: size.width * 0.050,
                            ))),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
