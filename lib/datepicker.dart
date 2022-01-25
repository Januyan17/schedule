import 'package:flutter/material.dart';

class DatePickerScreen extends StatefulWidget {
  const DatePickerScreen({Key? key}) : super(key: key);

  @override
  _DatePickerScreenState createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  DateTime dateTime = DateTime(2022);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Date Picker"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}',
              style: TextStyle(fontSize: 17.0),
            ),
            ElevatedButton(
                onPressed: () async {
                  DateTime? newdate = await showDatePicker(
                      context: context,
                      initialDate: dateTime,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2300));

                  if (newdate != null) {
                    setState(() {
                      dateTime = newdate;
                    });
                  }
                },
                child: Text("Choose Date ")),
          ],
        ),
      ),
    );
  }
}
