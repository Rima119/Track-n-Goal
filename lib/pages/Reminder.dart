//Create reminder page to set reminder for specific goals
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

//Implementation of a select_from_field section where user can select one of his goals from a list and set a reminder for it
class _ReminderPageState extends State<ReminderPage> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();

  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  bool readOnly = true;
  bool showResetIcon = true;
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
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
            //Dropdownbutton from which you can select a goal to set a reminder for
            DropdownButton(
              items: [
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
              ],
              onChanged: (value) {
                print(value);
              },
              hint: Text("Select a goal",
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
            Container(
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
          ],
        ),
      ),
    );
  }
}
