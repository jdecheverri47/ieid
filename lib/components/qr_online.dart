import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrOnline extends StatelessWidget {
  QrOnline({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: QrImageView(
        data: 'https://www.youtube.com/forms?user=${user.uid}',
        size: 200,
      ),
    );
  }
}