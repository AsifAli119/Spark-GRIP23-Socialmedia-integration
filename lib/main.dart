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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomePage();
              } else {
                return const LoginPage();
              }
            }),
      ),
      routes: {
        MyRoutes.loginPage: (context) => const LoginPage(),
        MyRoutes.signUpPage: (context) => const SignUp(),
        MyRoutes.homePage: (context) => const HomePage(),
      },
    );
  }
}
