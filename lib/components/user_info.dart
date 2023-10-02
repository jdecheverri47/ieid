import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyUserInfo extends StatefulWidget {
  const MyUserInfo({Key? key}) : super(key: key);

  @override
  State<MyUserInfo> createState() => _MyUserInfoState();
}

class _MyUserInfoState extends State<MyUserInfo> {
  String user = FirebaseAuth.instance.currentUser!.uid;

  Future<void> getUser() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(user).get();

    String firstname = doc['firstname'];
    String lastname = doc['lastname'];
    String email = doc['email'];
    String phone = doc['phone'];
    String company = "Internacional de Electricos";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child:  Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: const AssetImage('lib/images/user.png'),
                  backgroundColor: Colors.grey[300],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "JOSE ECHEVERRI",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      Text(
                        "Internacional de Electricos",
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'josecheverri47@gmail.com',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Phone: 3022166275',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

