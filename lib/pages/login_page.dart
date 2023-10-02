import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieid/components/my_textfields.dart';
import 'package:ieid/components/my_button.dart';
import 'package:ieid/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {

    showDialog(
      context: context,
      builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
      );
      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        invalidCredentials();
      } else if (e.code == 'wrong-password') {
        noPasswordMessage();
      } else {
        print(e);
      }
    }
  }

  void invalidCredentials() {
    showDialog(
      context: context,
      builder: (context) {
      return AlertDialog(
        title: const Text('Wrong Credentials'),
        content: const Text('The email or password you entered is incorrect'),
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

  void noPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
      return AlertDialog(
        title: const Text('Wrong Password'),
        content: const Text('Please type your password.'),
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
    return Scaffold(
      backgroundColor: Colors.white,
      body:  SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Image.asset(
              'lib/images/logo-ie-header.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20,),
            const Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 1.3
              ),
            ),

            const SizedBox(height: 8),
            Text(
              'You have been missed',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.grey.shade700,
                letterSpacing: 1.1
              ),
            ),

            const SizedBox(height: 30,),

            MyTextField(
              hintText: 'Email',
              controller: emailController,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 15),

            MyTextField(
              hintText: 'Password',
              controller: passwordController,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),

            const SizedBox(height: 15),

            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text('Forgot Password?',
                  style: TextStyle(
                    color: Colors.black,
                  ),),
                ),
              ],
            ),

            const SizedBox(height: 15),
            MyButton(
              text: "Login",
              color: Colors.yellow.shade600,
              onPressed: signUserIn,
            ),

            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade400,
                      thickness: 1,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('OR',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),),
                  ),

                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade400,
                      thickness: 1,
                    ),
                  ),
                ]
              )
            ),

            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  minimumSize: const Size(220, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/images/google.png',
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(width: 10,),
                    const Text('Login with Google',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account? ',
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const RegisterPage()),);
                  },
                  child: const Text('Sign Up',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ],
            ),
                ],),
          )
        )
      ),
    );
  }
}