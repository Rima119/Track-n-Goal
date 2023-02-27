import 'package:flutter/material.dart';
import 'package:trackn_goal/Service/Auth_Service.dart';
import 'package:trackn_goal/pages/SignInPage.dart';
import 'package:trackn_goal/pages/SignUpPage.dart';
import 'package:trackn_goal/pages/PhoneAuth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

//settings page in the style of youtube settings page
class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

//settings page in the style of telegram settings page
class _SettingsPageState extends State<SettingsPage> {
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0Xff1d1e26),
            Color(0Xff252041),
          ]),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.blue,
              child: Center(
                child: Text(
                  "Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.blue,
              child: Center(
                child: Text(
                  "Notifications",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.blue,
              child: Center(
                child: Text(
                  "About",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.blue,
              child: Center(
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
