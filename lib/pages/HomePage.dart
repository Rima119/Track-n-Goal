import 'package:trackn_goal/Service/Auth_Service.dart';
import 'package:trackn_goal/main.dart';
import 'package:flutter/material.dart';
import 'package:trackn_goal/pages/GoalsList.dart';
import 'package:trackn_goal/pages/Settings.dart';
import 'package:trackn_goal/pages/RemindersList.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// Home page of the application
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
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 4, 46, 94),
            Color.fromARGB(255, 13, 24, 107),
            Color.fromARGB(255, 4, 46, 94),
          ]),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipOval(
                      child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 4, 46, 94),
                        Color.fromARGB(255, 13, 24, 107),
                        Color.fromARGB(255, 4, 46, 94),
                      ]),
                    ),
                    alignment: Alignment.center,
                    //use the logo image from the images folder

                    child: Image(
                        image: ResizeImage(AssetImage('assets/logo.png'),
                            width: 300, height: 300)),
                  )),
                  const SizedBox(height: 5),
                  const Text(
                      'Success is the progressive realization of\na worthy goal or ideal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
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
                              builder: (context) => RemindersListScreen()),
                        );
                      },
                      style: TextButton.styleFrom(
                        // fixedSize: const Size(40, 60),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        padding: const EdgeInsets.all(25),
                      ),
                      child: const Text("Reminders List",
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
                      child: const Text("Settings",
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
