import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import 'EditGoal.dart';
import 'AddGoal.dart';

class GoalsListScreen extends StatefulWidget {
  @override
  _GoalsListScreenState createState() => _GoalsListScreenState();
}

class _GoalsListScreenState extends State<GoalsListScreen> {
  List _goals = [];
  final database = openDatabase(
    'goals.db',
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE goals(id VARCHAR PRIMARY KEY, title TEXT, description TEXT)',
      );
    },
    version: 1,
  );

  @override
  void initState() {
    super.initState();
    _fetchGoals();
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

  Future<void> _fetchGoals() async {
    //Retrieve goals from goals database
    final db = await database;
    final results = await db.query('goals');
    setState(() {
      _goals = results;
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

  Future<void> _addGoal() async {
    //Add goal to goals database
    final db = await database;
    await db.insert(
      'goals',
      {
        'id': Uuid().v4().toString(),
        'title': "title",
        'description': "description"
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    final results = await db.query('goals');
    setState(() {
      _goals = results;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goals List'),
      ),
      body: _goals.isEmpty
          ? Center(child: Text('No goals yet'))
          : ListView.builder(
              itemCount: _goals.length,
              itemBuilder: (context, index) {
                final goal = _goals[index];

                return ListTile(
                    title: Text(goal["title"]),
                    subtitle: Text(goal["description"]),
                    //add a delete button
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            final db = await database;
                            await db.delete(
                              'goals',
                              where: 'id = ?',
                              whereArgs: [goal["id"]],
                            );
                            _fetchGoals();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (_) => EditGoalScreen(
                                  id: goal["id"],
                                  title: goal["title"],
                                  description: goal["description"]),
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
