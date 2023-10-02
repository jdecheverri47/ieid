
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieid/components/my_textfields.dart';
import 'package:ieid/utils/my_service.dart';
import '../utils/user_json.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}



class _RegisterPageState extends State<RegisterPage> with TickerProviderStateMixin {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

  late AnimationController _animationController;
  late Widget _tick;

  Future<void> signUp() async {
    showDialog(
      context: context,
      builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
      );

      String user = FirebaseAuth.instance.currentUser!.uid;

      if (user.isNotEmpty) {
        await FirebaseFirestore.instance.collection('users').doc(user).set({
          'firstname': firstnameController.text,
          'lastname': lastnameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'userId': user,
        });

        UserModel userData = UserModel(
          firstname: firstnameController.text,
          email: emailController.text,
          phone: phoneController.text,
          userId: user,
        );

        final json = userData.toJson();

        await MyService.instance.storage.setItem('user', json);
      }




      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == 'weak-password') {
        weakPasswordMessage();

      } else if (e.code == 'email-already-in-use') {
        emailAlreadyInUseMessage();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),

    );

    _tick = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Icon(
          Icons.check,
          color: Colors.green,
          size: 50 * _animationController.value,
        );
      }
      );
  }
  void weakPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
      return AlertDialog(
        title: const Text('Weak Password'),
        content: const Text('The password you entered is too weak'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ],
      );
    });
  }

  void emailAlreadyInUseMessage() {
    showDialog(
      context: context,
      builder: (context) {
      return AlertDialog(
        title: const Text('Email Already in Use'),
        content: const Text('The email you entered is already in use'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),
              const Text(
                'Create account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 30,),
              MyTextField(
                hintText: 'First name',
                obscureText: false,
                controller: firstnameController,
                keyboardType: TextInputType.name,
              ),

              const SizedBox(height: 20,),
              MyTextField(
                hintText: 'Last name',
                obscureText: false,
                controller: lastnameController,
                keyboardType: TextInputType.name,
              ),

              const SizedBox(height: 20,),
              MyTextField(
                hintText: 'Phone number',
                obscureText: false,
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 20,),
              MyTextField(
                hintText: 'Email',
                obscureText: false,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20,),
              MyTextField(
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
              ),



              const SizedBox(height: 25,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'By creating an account, you agree to our Terms of Service and Privacy Policy.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      signUp();
                      _animationController.forward();

                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pop(context);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.yellow.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              _tick
            ],
          ),
        ),
      )
    );
  }
}