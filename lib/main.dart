import 'package:flutter/foundation.dart';
import 'package:trackn_goal/Service/Auth_Service.dart';
import 'package:trackn_goal/pages/AddGoal.dart.';
import 'package:trackn_goal/pages/HomePage.dart';
import 'package:trackn_goal/pages/SignInPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trackn_goal/pages/SignUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBrzU9k8LLJ5pK9jrHSD1h4QTpBzOvcZcE",
        appId: "1:290387344582:web:42e3a0edaf5a93842bebc7",
        messagingSenderId: "290387344582",
        projectId: "track-n-goal",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthClass authClass = AuthClass();
  Widget currentPage = SignUpPage();

  @override
  void initState() {
    super.initState();
    // authClass.signOut();
    checkLogin();
  }

  checkLogin() async {
    String tokne = await authClass.getToken();
    print("tokne");
    if (tokne != null) {
      setState(() {
        currentPage = HomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: currentPage,
    );
  }
}
