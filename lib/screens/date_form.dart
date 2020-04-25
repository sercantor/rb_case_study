import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sleep_tracker/model/custom_picker.dart';
import 'package:sleep_tracker/provider/date_provider.dart';
import 'package:provider/provider.dart';

class DateForm extends StatefulWidget {
  @override
  _DateFormState createState() => _DateFormState();
}

class _DateFormState extends State<DateForm> {
  final formattedDateTimeNow = DateFormat.jm().format(DateTime.now());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateTimeController = TextEditingController(
      text: DateFormat('d MMMM y, H:mm').format(DateTime.now()));
  final TextEditingController hoursAndMinutes = TextEditingController();
  String sleepType;

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DateProvider>(context);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: <Color>[
                Colors.deepOrange[700],
                Colors.indigo[900],
              ],
            ),
          ),
        ),
        title: Text('Sleep Tracker'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image(
                  image: AssetImage('./lib/assets/mom_son.jpg'),
                  fit: BoxFit.fill),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: dateTimeController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.date_range,
                          color: Colors.indigo[900],
                        ),
                        labelText: 'Date and time',
                        labelStyle: TextStyle(
                            color: Colors.indigo[900],
                            fontWeight: FontWeight.bold),
                      ),
                      enabled: false,
                    ),
                    DropdownButtonFormField<String>(
                      isDense: true,
                      value: sleepType,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.brightness_3,
                          color: Colors.indigo[900],
                        ),
                        labelText: 'Sleep Type',
                        labelStyle: TextStyle(
                            color: Colors.indigo[900],
                            fontWeight: FontWeight.bold),
                      ),
                      onChanged: (type) => setState(() => sleepType = type),
                      validator: (value) {
                        if (value == null) {
                          return 'Fill the sleep type before saving.';
                        } else {
                          return null;
                        }
                      },
                      items: ['Night\'s sleep', 'Nap']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    TextFormField(
                      controller: hoursAndMinutes,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Fill the hours and minutes field before saving.';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Sleep Time',
                          labelStyle: TextStyle(
                              color: Colors.indigo[900],
                              fontWeight: FontWeight.bold),
                          prefixIcon: Icon(
                            Icons.access_time,
                            color: Colors.indigo[900],
                          )),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        DatePicker.showPicker(context, showTitleActions: true,
                            onConfirm: (date) {
                          hoursAndMinutes.text =
                              '${date.hour} hours and ${date.minute} minutes';
                        },
                            pickerModel:
                                CustomPicker(currentTime: DateTime.now()),
                            locale: LocaleType.en);
                      },
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.indigo[700],
                        child: Text(
                          'Save',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            dateProvider.setDateListHour(formattedDateTimeNow);
                            dateProvider.setSleepType(sleepType);
                            dateProvider.setSleepTime(hoursAndMinutes.text);
                            Navigator.of(context).pop();
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
