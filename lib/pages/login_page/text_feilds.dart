import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sm_login/pages/routes.dart';

import '../register_page/register_page.dart';
import 'buttons.dart';

TextEditingController _emailTxtController = TextEditingController();
TextEditingController _passwordTxtController = TextEditingController();

class TextFeilds extends StatelessWidget {
  const TextFeilds({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    loginToFirebase() {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: _emailTxtController.text,
          password: _passwordTxtController.text)
          .then((userCredential) async{
        await  Navigator.pushReplacementNamed(
            context, MyRoutes.homePage);
      });
    }

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(125, 95, 27, 3),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      )
                    ]),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]!))),
                      child: TextField(
                        controller: _emailTxtController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            hintText: "Enter your Email",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]!))),
                      child: TextField(
                        controller: _passwordTxtController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            hintText: "Enter your password",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Forgot Password?",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: loginToFirebase,
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue[900]!,
                          Colors.blue[700]!,
                          Colors.blue[500]!,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(125, 95, 27, 3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ]),
                  child: Center(
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
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
                  Text("Doesn't have an account?",
                      style: TextStyle(color: Colors.grey, fontSize: 15)),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: Container(
                        child: Text(" Create one",
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 15,
                                fontWeight: FontWeight.bold))),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Continue with social media!",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              SizedBox(
                height: 24,
              ),
              Buttons(),
            ],
          ),
        ),
      ),
    );
  }
}
