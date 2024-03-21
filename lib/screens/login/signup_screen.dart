import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/components/text_fields.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // text editing controllers
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmpasswordController = TextEditingController();

  void signUp() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (passwordController.text == confirmpasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());

        Navigator.pop(context);
      } else {
        showErrorMessage("Password don't match!");
      }
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);

      // show the error message
      showErrorMessage(e.code);
    }

    addDetails(nameController.text.trim(), emailController.text.trim(), phoneController.text.trim(), passwordController.text.trim());
  }

  void addDetails(String name, String email, String phoneNumber, String password) async {
    await FirebaseFirestore.instance.collection('Users').add({
      'Name': name,
      'Email': email,
      'Phone Number': phoneNumber,
      'Password': password,
    });
  }

  void validate() {
    if (emailController.text == " ") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Center(
              child: Row(
                children: [
                  Icon(Icons.error),
                  SizedBox(width: 6),
                  Text(
                    "Please enter your email",
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else if (passwordController.text == " ") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Center(
                child: Row(
                  children: [
                    Icon(Icons.error),
                    SizedBox(width: 6),
                    Text(
                      "Please enter your password",
                    ),
                  ],
                ),
              ),
            );
          });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Center(
              child: Row(
                children: [
                  Icon(Icons.error),
                  SizedBox(width: 6),
                  Text(
                    "Please enter your login details",
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Row(
              children: [
                const Icon(Icons.error),
                const SizedBox(width: 6),
                Text(
                  message,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        foregroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 5),

              //logo
              const Image(
                image: AssetImage('assets/images/login.png'),
                width: 120,
                height: 120,
              ),

              const SizedBox(height: 25),

              // sub - text
              Center(
                child: Text(
                  "Take care of your pets, Register",
                  style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue, fontSize: 18),
                ),
              ),

              const SizedBox(height: 20),

              //text-fields username and password
              MyTextField(
                  controller: nameController,
                  hintText: 'Enter name',
                  obscureText: false,
                  icon: Icon(
                    Icons.keyboard,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                    size: 25,
                  )),
              const SizedBox(height: 15),

              MyTextField(
                  controller: emailController,
                  hintText: 'Enter email',
                  obscureText: false,
                  icon: Icon(
                    Icons.email,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                    size: 25,
                  )),
              const SizedBox(height: 15),

              MyTextField(
                  controller: phoneController,
                  hintText: 'Enter phone number',
                  obscureText: false,
                  icon: Icon(
                    Icons.phone,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                    size: 25,
                  )),
              const SizedBox(height: 15),

              MyTextField(
                  controller: passwordController,
                  hintText: 'Enter password',
                  obscureText: true,
                  icon: Icon(
                    Icons.password,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                    size: 25,
                  )),
              const SizedBox(height: 15),

              MyTextField(
                  controller: confirmpasswordController,
                  hintText: 'Enter password again',
                  obscureText: true,
                  icon: Icon(
                    Icons.password,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                    size: 25,
                  )),
              const SizedBox(height: 15),

              // signin button
              TextButton(
                onPressed: () {
                  signUp();
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),

              // already sign in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Login Now',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
