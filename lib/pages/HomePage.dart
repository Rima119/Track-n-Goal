import 'package:trackn_goal/Service/Auth_Service.dart';
import 'package:trackn_goal/main.dart';
import 'package:flutter/material.dart';
import 'package:trackn_goal/pages/GoalsList.dart';
import 'package:trackn_goal/pages/Settings.dart';
import 'package:trackn_goal/pages/Reminder.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await authClass.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => MyApp()),
                    (route) => false);
              }),
        ],
      ),
      body: Container(
        color: Colors.lightBlueAccent,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipOval(
                      child: Container(
                          width: 180,
                          height: 180,
                          color: Colors.lightBlueAccent,
                          alignment: Alignment.center,
                          //use the crosshair image from the images folder

                          child: Image.asset('images/crosshair.png'))),
                  const SizedBox(height: 20),
                  const Text("Track'N Goal",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold)),
                  const Text(
                      'Success is the progressive realization of\na worthy goal or ideal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GoalsListScreen()),
                        );
                      },
                      style: TextButton.styleFrom(
                        // fixedSize: const Size(40, 60),
                        backgroundColor: Colors.blue,
                        /*foregroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState>states) {
                          if(states.contains(MaterialState.hovered)){
                            return Colors.green;
                          }),*/
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        padding: const EdgeInsets.all(25),
                      ),
                      child: const Text("Goals List",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReminderPage()),
                        );
                      },
                      style: TextButton.styleFrom(
                        // fixedSize: const Size(40, 60),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        padding: const EdgeInsets.all(25),
                      ),
                      child: const Text("Reminder",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage()),
                        );
                      },
                      style: TextButton.styleFrom(
                        // fixedSize: const Size(40, 60),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        padding: const EdgeInsets.all(25),
                      ),
                      child: const Text("User Account",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
