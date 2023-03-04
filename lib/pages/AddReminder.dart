import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AddReminderPage extends StatefulWidget {
  @override
  _AddReminderPageState createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();
  var _selectedgoal = "Select a goal";
  // text controller for the date field
  final TextEditingController _dateController = TextEditingController();

  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  bool readOnly = true;
  bool showResetIcon = true;
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;

  List _goals = [];

  @override
  void initState() {
    super.initState();
    _fetchGoals();
  }

  Future<void> _fetchGoals() async {
    //Retrieve goals from goals database
    final results = await FirebaseFirestore.instance
        .collection('goals')
        .where('user',
            isEqualTo: firebase_auth.FirebaseAuth.instance.currentUser.email)
        .get();
    setState(() {
      _goals = results.docs;
    });
  }

  //Implementing the function to set a reminder for a goal
  Future<void> _setReminder(_selectedDate) async {
    var uuid = Uuid();
    var id = uuid.v4();
    var title = _selectedgoal;
    var description = "This is a reminder for the goal " + _selectedgoal;
    var date = _selectedDate;
    await FirebaseFirestore.instance.collection('reminders').doc(id).set(
      {
        'id': id,
        'title': title,
        'description': description,
        'date': date,
        'user': firebase_auth.FirebaseAuth.instance.currentUser.email,
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Reminder set for goal " + _selectedgoal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reminder"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0Xff1d1e26),
            Color(0Xff252041),
          ]),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            //Dropdownbutton from which you can select a goal to set a reminder for and the goal is one of the goals the user has set

            DropdownButton(
              items: _goals.map<DropdownMenuItem>((goal) {
                return DropdownMenuItem(
                  value: goal,
                  child: Text(goal["title"]),
                );
              }).toList(),
              /*[
                DropdownMenuItem(
                  child: Text("Goal 1"),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("Goal 2"),
                  value: 2,
                ),
                DropdownMenuItem(
                  child: Text("Goal 3"),
                  value: 3,
                ),
              ]*/
              onChanged: (goal) {
                setState(() {
                  _selectedgoal = goal["title"];
                });
              },
              hint: Text(_selectedgoal,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            //Implement a calendar from where you can select a date to set a reminder for
            Column(children: <Widget>[
              Text('Choose a date and time for your reminder',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              DateTimeField(
                controller: _dateController,
                format: format,
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                autovalidateMode: autoValidateMode,
                validator: (date) => date == null ? 'Invalid date' : null,
                initialValue: initialValue,
                onSaved: (date) => setState(() {
                  value = date;
                  savedCount++;
                }),
                resetIcon: showResetIcon
                    ? Icon(
                        Icons.delete,
                        color: Colors.red,
                      )
                    : null,
                readOnly: readOnly,
              ),
            ]),
            SizedBox(
              height: 75,
            ),
            //Implement a button to set the reminder
            GestureDetector(
              onTap: () {
                _setReminder(_dateController.text);
              },
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    "Set a reminder",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
