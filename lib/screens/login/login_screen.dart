import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/ZOne/homescreen.dart';
import 'package:pet_care/components/text_fields.dart';

import '../../Auth/authentication.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  void signInGoogle() {
    Authentication().signInGoogle();
  }

  void signIn() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // validate();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      print(e.message);
    }
  }

  void validate() {
    if (emailController.text == " ") {
      Navigator.pop(context);
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
      Navigator.pop(context);

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
      Navigator.pop(context);

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
                    "Please enter your \nlogin details",
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              Text(
                "Welcome back, take care of your pets",
                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue, fontSize: 18),
              ),

              const SizedBox(height: 20),

              //text-fields username and password
              MyTextField(
                controller: emailController,
                hintText: 'Enter email',
                obscureText: false,
                icon: Icon(
                  Icons.person_2_outlined,
                  size: 25,
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              MyTextField(
                  controller: passwordController,
                  hintText: 'Enter password',
                  obscureText: true,
                  icon: Icon(
                    Icons.password,
                    size: 25,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                  )),

              // forget password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // signin button
              TextButton(
                onPressed: () {
                  signIn();
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              //Or Continue with (google + other options)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Color.fromARGB(255, 143, 141, 135)),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  signInGoogle();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.blue.shade400 : Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/google.png'),
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Log In with Google',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // not sign in , register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Not a member?',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up Now',
                      style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue),
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
