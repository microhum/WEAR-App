import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class WelcomeScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  String username() {
    final str = auth.currentUser!.email!;
    var parts = str.split('@');
    var name = parts[0];
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ยินดีต้อนรับ"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              Text(
                "สวัสดี " + username(),
                style: TextStyle(fontSize: 25),
              ),
              ElevatedButton(
                child: Text("ออกจากระบบ"),
                onPressed: () {
                  auth.signOut().then((value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    }));
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
