import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sm_login/pages/register_page/register_page.dart';
import 'package:sm_login/pages/routes.dart';
import 'package:sm_login/sign_in_provider/sign_provider.dart';
class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: ()async{
              await signInProvider.signInWithFacebook().then((value){
                Navigator.pushReplacementNamed(
                    context, MyRoutes.homePage);
              });
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.deepPurpleAccent,
                  boxShadow: [
              BoxShadow(
              color: Color.fromARGB(125, 95, 27, 3),
      blurRadius: 20,
      offset: Offset(0, 10),
    )
    ]
              ),
              child: Center(
                child: Text(
                  "Facebook",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 25,),
        Expanded(
          child: InkWell(
            onTap: ()=> SignInProvider().signInWithGoogle().then((value){
              
    Navigator.pushReplacementNamed(
    context, MyRoutes.homePage);
    }),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(125, 95, 27, 3),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    )
                  ]
              ),
              child: Center(
                child: Text(
                  "Google",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),

            ),
          ),
        ),
      ],
    );
  }
}