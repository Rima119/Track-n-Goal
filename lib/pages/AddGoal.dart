import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trackn_goal/pages/GoalsList.dart';
import 'package:uuid/uuid.dart';

class AddGoalPage extends StatefulWidget {
  AddGoalPage({Key key}) : super(key: key);

  @override
  State<AddGoalPage> createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> addGoal(String goalTitle, String goalDescription) async {
    // Open the database
    final Database db = await openDatabase(
      'goals.db',
      version: 1,
      onCreate: (Database db, int version) async {
        // Create the goals table if it doesn't already exist
        await db.execute(
            'CREATE TABLE goals (id TEXT PRIMARY KEY, title TEXT, description TEXT)');
      },
    );

    // Insert the goal into the database
    await db.insert(
      'goals',
      {
        'id': Uuid().v4().toString(),
        'title': goalTitle,
        'description': goalDescription
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Close the database
    //await db.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 88, 101, 199),
            Color.fromARGB(255, 60, 119, 187),
          ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => GoalsListScreen(),
                  ));
                },
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "New Goal",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    label("Goal Title"),
                    SizedBox(
                      height: 12,
                    ),
                    title(),
                    SizedBox(
                      height: 25,
                    ),
                    label("Goal Type"),
                    SizedBox(
                      height: 17,
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        chipData("Important", 0xff2123fb),
                        SizedBox(
                          width: 20,
                        ),
                        chipData("Planned", 0xff2784fa),
                        SizedBox(
                          width: 20,
                        ),
                        chipData("Habit", 0xff11b5fc),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    label("Goal Description"),
                    SizedBox(
                      height: 12,
                    ),
                    description(),
                    SizedBox(
                      height: 25,
                    ),
                    label("Category"),
                    SizedBox(
                      height: 17,
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        chipData("Sport", 0xff2674fa),
                        SizedBox(
                          width: 20,
                        ),
                        chipData("Work", 0xff2bc3d9),
                        SizedBox(
                          width: 20,
                        ),
                        chipData("Studies", 0xffe5915a),
                        SizedBox(
                          width: 20,
                        ),
                        chipData("Learning", 0xffb58891),
                        SizedBox(
                          width: 20,
                        ),
                        chipData("Food", 0xffb5589d),
                        SizedBox(
                          width: 20,
                        ),
                        chipData("Design", 0xffb5c7df),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    button(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget button() {
    return GestureDetector(
      onTap: () {
        addGoal(_titleController.text, _descriptionController.text);
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 32, 10, 158),
              Color.fromARGB(255, 43, 21, 165),
              Color.fromARGB(255, 49, 10, 138),
            ],
          ),
        ),
        child: Center(
          child: Text(
            "Add Goal",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
    /*return Container(
      height: 56,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Color(0xff8a12f1),
            Color(0xff8a12f1),
          ],
        ),
      ),
      child: Center(
        child: Text(
          "Add Goal",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );*/
  }

  Widget description() {
    return Container(
      height: 155,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _descriptionController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a description';
          }
          return null;
        },
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        maxLines: null,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Goal Title",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
            contentPadding: EdgeInsets.only(
              left: 20,
              right: 20,
            )),
      ),
    );
  }

  Widget chipData(String label, int color) {
    return Chip(
      backgroundColor: Color(color),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      labelPadding: EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 3.8,
      ),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _titleController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a title';
          }
          return null;
        },
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Goal Title",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
            contentPadding: EdgeInsets.only(
              left: 20,
              right: 20,
            )),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16.5,
        letterSpacing: 0.2,
      ),
    );
  }
}
