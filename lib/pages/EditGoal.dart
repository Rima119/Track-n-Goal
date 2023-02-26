import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class EditGoalScreen extends StatefulWidget {
  final id, title, description;

  EditGoalScreen({this.id, this.title, this.description});

  @override
  _EditGoalScreenState createState() => _EditGoalScreenState();
}

class _EditGoalScreenState extends State<EditGoalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final database = openDatabase(
    'goals.db',
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE goals(id VARCHAR PRIMARY KEY, title TEXT, description TEXT)',
      );
    },
    version: 1,
  );

  Future<void> _editGoal(id, title, description) async {
    //update goal in goals database based on id, title, and description
    final db = await database;

    await db.update(
      'goals',
      {'title': title, 'description': description},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title;
    _descriptionController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Goal'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Enter the goal title',
              ),
              controller: _titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter the goal description',
              ),
              controller: _descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _editGoal(widget.id, _titleController.text,
                      _descriptionController.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Update Goal'),
            ),
          ],
        ),
      ),
    );
  }
}
