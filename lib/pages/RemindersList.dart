import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import 'EditGoal.dart';
import 'AddReminder.dart';

class RemindersListScreen extends StatefulWidget {
  @override
  _RemindersListScreenState createState() => _RemindersListScreenState();
}

class _RemindersListScreenState extends State<RemindersListScreen> {
  List _reminders = [];
  List _reminders2 = [];
  final database = openDatabase(
    'reminders.db',
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE reminders(id VARCHAR PRIMARY KEY, title TEXT, description TEXT, date TEXT)',
      );
    },
    version: 1,
  );

  @override
  void initState() {
    super.initState();
    _fetchReminders();
    // _addGoal();
  }

  /*Future<void> _connectToDatabase() async {
    //connect to database
    final database = openDatabase(
      'goals.db',
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE goals(id VARCHAR PRIMARY KEY, title TEXT, description TEXT)',
        );
      },
      version: 1,
    );
    _fetchGoals(database);
  }*/

  Future<void> _fetchReminders() async {
    //Retrieve goals from goals database
    final db = await database;
    //Delete all reminders from database
    //await db.delete('reminders');
    final results = await db.query('reminders');
    setState(() {
      _reminders = results;
      _reminders2 = results;
    });
    /*final goals = results
        .map((row) => Goal(
              id: row[0] as String,
              title: row[1] as String,
              description: row[2] as String,
            ))
        .toList();

    setState(() {
      _goals = goals;
    });*/
  }

  //Implementing a searching method to print goals as you type them in the search box
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
          setState(() {
            _reminders = value == "" ||
                    _reminders2
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
                ? _reminders2
                : _reminders2
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
        title: Text('Reminders List'),
      ),
      body: _reminders.isEmpty
          ? Center(child: Text('No Reminder set yet'))
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
                      itemCount: _reminders.length,
                      itemBuilder: (context, index) {
                        final reminder = _reminders[index];

                        return ListTile(
                            //change background color of list tile
                            tileColor: Color.fromARGB(255, 37, 59, 158),
                            contentPadding: EdgeInsets.all(16),
                            title: Text(
                              reminder["title"],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              reminder["description"] + " " + reminder["date"],
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
                                    final db = await database;
                                    await db.delete(
                                      'reminders',
                                      where: 'id = ?',
                                      whereArgs: [reminder["id"]],
                                    );
                                    _fetchReminders();
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
            builder: (_) => AddReminderPage(),
          ))
              .then((_) {
            _fetchReminders();
          });
        },
      ),
    );
  }
}
