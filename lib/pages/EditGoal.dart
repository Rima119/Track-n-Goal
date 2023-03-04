import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditGoalScreen extends StatefulWidget {
  final id, title, description, user;

  EditGoalScreen({this.id, this.title, this.description, this.user});

  @override
  _EditGoalScreenState createState() => _EditGoalScreenState();
}

class _EditGoalScreenState extends State<EditGoalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> _editGoal(id, title, description, user) async {
    //update goal in cloud_firestore database
    await FirebaseFirestore.instance.collection('goals').doc(id).set(
        {'id': id, 'title': title, 'description': description, 'user': user},
        SetOptions(merge: true));
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
              style: TextStyle(
                color: Colors.grey,
                fontSize: 17,
              ),
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
              style: TextStyle(
                color: Colors.grey,
                fontSize: 17,
              ),
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
                      _descriptionController.text, widget.user);
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
