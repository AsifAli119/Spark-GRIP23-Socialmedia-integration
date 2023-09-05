import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sm_login/pages/home_page/home_page.dart';
import 'package:sm_login/pages/login_page/login_page.dart';
import 'package:sm_login/pages/register_page/register_page.dart';
import 'package:sm_login/pages/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness ==  Brightness.dark;
    return MaterialApp(
      theme: ThemeData(
          brightness:isDark? Brightness.dark: Brightness.light
      ),
      debugShowCheckedModeBanner: false ,
      home: Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return LoginPage();
              }
              else {
                return SignUp();
              }
            }
        ),
      ),routes: {
      MyRoutes.loginPage: (context) => LoginPage(),
      MyRoutes.signUpPage: (context) => SignUp(),
      MyRoutes.homePage: (context) => HomePage(),

    },
    );
  }
}


