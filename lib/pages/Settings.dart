import 'package:flutter/material.dart';
import 'package:trackn_goal/Service/Auth_Service.dart';
import 'package:trackn_goal/pages/SignInPage.dart';
import 'package:trackn_goal/pages/SignUpPage.dart';
import 'package:trackn_goal/pages/PhoneAuth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';

//settings page in the style of youtube settings page
class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

//settings page in the style of telegram settings page
class _SettingsPageState extends State<SettingsPage> {
  AuthClass authClass = AuthClass();
  bool _switchValue = false;
  var goalsnum = 0;

  @override
  void initState() {
    super.initState();
    _fetchGoals();
  }

  //Implementing to count the number of goals
  Future<void> _fetchGoals() async {
    //Retrieve goals from goals database
    final results = await FirebaseFirestore.instance
        .collection('goals')
        .where('user',
            isEqualTo: firebase_auth.FirebaseAuth.instance.currentUser.email)
        .get();
    //update the number of goals
    setState(() {
      goalsnum = results.docs.length;
    });
  }

  //Implementing the about page
  void _showAboutPage() {
    showAboutDialog(
      context: context,
      applicationName: 'TrackNGoal',
      applicationVersion: '1.0.0',
      applicationIcon: Image.asset(
        'assets/logo.png',
        width: 50,
        height: 50,
      ),
      applicationLegalese: '© 2021 TrackNGoal',
      children: [
        Text(
          'TrackNGoal is a goal tracking app that helps you achieve your goals by tracking your progress and reminding you to work on your goals.',
        ),
      ],
    );
  }

  //Implementing the log out button method
  void _logOut() async {
    await authClass.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (builder) => SignInPage()),
        (route) => false);
  }

  //Implementing the user account page
  void _showUserAccountPage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("User Account"),
          content: Container(
            height: 200,
            child: Column(
              children: [
                Text(
                  "Email: ${firebase_auth.FirebaseAuth.instance.currentUser.email}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Number of goals: $goalsnum",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

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
            //Button to show the user account page
            GestureDetector(
              onTap: () {
                _showUserAccountPage();
              },
              child: Container(
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
            ),
            SizedBox(
              height: 20,
            ),
            //Button to activate or deactivate notifications
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      "Notifications",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Switch(
                    //Make the switch value true or false

                    activeColor: Colors.white,
                    activeTrackColor: Colors.green,
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        _switchValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //Button to show the about page
            GestureDetector(
              onTap: () {
                _showAboutPage();
              },
              child: Container(
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
            ),
            SizedBox(
              height: 20,
            ),
            //Button to log out
            GestureDetector(
              onTap: () {
                _logOut();
              },
              child: Container(
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
