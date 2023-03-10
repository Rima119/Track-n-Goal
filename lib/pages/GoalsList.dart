import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'EditGoal.dart';
import 'AddGoal.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class GoalsListScreen extends StatefulWidget {
  @override
  _GoalsListScreenState createState() => _GoalsListScreenState();
}

class _GoalsListScreenState extends State<GoalsListScreen> {
  List _goals = [];
  List _goals2 = [];
  CollectionReference goalsCollection;

  @override
  void initState() {
    super.initState();
    goalsCollection = FirebaseFirestore.instance.collection('goals');
    _fetchGoals();
  }

  Future<void> _fetchGoals() async {
    //Retrieve the user's goals from cloud_firestorage database and store them in a list
    final results = await goalsCollection
        .where('user',
            isEqualTo: firebase_auth.FirebaseAuth.instance.currentUser.email)
        .get();
    //update the list of goals
    setState(() {
      _goals = results.docs;
      _goals2 = results.docs;
    });
  }

  Widget searchBox() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          border: InputBorder.none,
          icon: Icon(Icons.search),
        ),
        onChanged: (value) {
          //Method to search for goals

          setState(() {
            _goals = value == "" ||
                    _goals2
                        .where((element) =>
                            element["title"]
                                .toString()
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element["description"]
                                .toString()
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                        .toList()
                        .isEmpty
                ? _goals2
                : _goals2
                    .where((element) =>
                        element["title"]
                            .toString()
                            .toLowerCase()
                            .contains(value.toLowerCase()) ||
                        element["description"]
                            .toString()
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                    .toList();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goals List'),
      ),
      body: _goals.isEmpty
          ? Center(child: Text('No goals yet'))
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0Xff1d1e26),
                  Color(0Xff252041),
                ]),
              ),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _goals.length,
                      itemBuilder: (context, index) {
                        final goal = _goals[index];

                        return ListTile(
                            //change background color of list tile
                            tileColor: Color.fromARGB(255, 37, 59, 158),
                            contentPadding: EdgeInsets.all(16),
                            title: Text(
                              goal["title"],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              goal["description"],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            //add a delete button
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    await goalsCollection
                                        .doc(goal["id"])
                                        .delete();
                                    _fetchGoals();
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.white),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (_) => EditGoalScreen(
                                        id: goal["id"],
                                        title: goal["title"],
                                        description: goal["description"],
                                        user: goal["user"],
                                      ),
                                    ))
                                        .then((_) {
                                      _fetchGoals();
                                    });
                                  },
                                ),
                              ],
                            ));
                      },
                    ),
                  )
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (_) => AddGoalPage(),
          ))
              .then((_) {
            _fetchGoals();
          });
        },
      ),
    );
  }
}
