import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(
            color: Colors.black
            )
          ),
        backgroundColor: Colors.yellow[600],
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout)
            )
          ],
      ),
      body: Center(
        child: QrImageView(
          data: 'https://price-eventually-eden-pour.trycloudflare.com/forms?user=${user.uid}',
          size: 200
          ),
      ),
    );
  }
}

