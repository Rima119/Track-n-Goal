import 'package:flutter/material.dart';

class User {
  final String imagePath;
  final String name;
  final String email;
  // final String isDarkMode;
  // final Int currentGoals;

  const User({
    @required this.imagePath,
    @required this.name,
    @required this.email,
    // required this.isDarkMode,
    // required this.currentGoals,
  });
}

class UserPreferences {
  static const currentUser = User(
    imagePath: 'assets/user.png',
    name: 'John Wick',
    email: 'joe_wi@gmail.com',
    // isDarkMode: false
  );
}
