import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? email = FirebaseAuth.instance.currentUser?.email.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: Icon(Icons.draw_rounded),
        title: const Text("Home Page"),
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 40)),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey, // Shadow color
                  blurRadius: 5, // Spread of the shadow
                  offset: Offset(0, 3), // Offset of the shadow
                ),
              ],
            ),
            child: Column(
              children: [
                // Display the profile image if available
                if (FirebaseAuth.instance.currentUser?.photoURL != null)
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        FirebaseAuth.instance.currentUser!.photoURL!),
                    radius: 20, // Adjust the radius as needed
                  ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  FirebaseAuth.instance.currentUser?.displayName ?? 'Asif Ali',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                // Display the email
                Text(
                    "Email: ${FirebaseAuth.instance.currentUser?.email ?? 'Unknown'}"),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacementNamed(
                      context, MyRoutes.loginPage);
                });
              },
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
