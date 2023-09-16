import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sm_login/pages/routes.dart';

import '../register_page/register_page.dart';
import 'buttons.dart';

TextEditingController _emailTxtController = TextEditingController();
TextEditingController _passwordTxtController = TextEditingController();
bool _isLoading = false;

class TextFeilds extends StatefulWidget {
  const TextFeilds({
    super.key,
  });

  @override
  State<TextFeilds> createState() => _TextFeildsState();
}

class _TextFeildsState extends State<TextFeilds> {
  @override
  Widget build(BuildContext context) {
    void loginToFirebase() async {
      setState(() {
        _isLoading = true; // Start loading
      });

      showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        },
      );

      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailTxtController.text,
                password: _passwordTxtController.text)
            .then((userCredential) async {
          // Successful login, dismiss the progress dialog
          Navigator.of(context).pop(); // Dismiss the dialog
          await Navigator.pushReplacementNamed(context, MyRoutes.homePage);
        });
      } catch (e) {
        setState(() {
          _isLoading = false; // Stop loading
        });
        // Handle the exception and show a SnackBar to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("ERROR: $e"),
          ),
        );
        Navigator.of(context).pop(); // Dismiss the dialog in case of an error
      }
    }

    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Container(
          height: MediaQuery.of(context).size.height*10,
          padding: EdgeInsets.zero,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(
                  height: 75.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(125, 95, 27, 3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ]),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[200]!))),
                        child: TextField(
                          controller: _emailTxtController,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.email),
                              hintText: "Enter your Email",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[200]!))),
                        child: TextField(
                          controller: _passwordTxtController,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.lock),
                              hintText: "Enter your password",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: loginToFirebase,
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue[900]!,
                            Colors.blue[700]!,
                            Colors.blue[500]!,
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(125, 95, 27, 3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )
                        ]),
                    child: const Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15)),
                    const Text("Doesn't have an account?",
                        style: TextStyle(color: Colors.grey, fontSize: 15)),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                        );
                      },
                      child: Text(" Create one",
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Continue with social media!",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Buttons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
