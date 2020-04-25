import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleep_tracker/provider/date_provider.dart';
import 'date_form.dart';

class StartScreen extends StatelessWidget {
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
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Icon(
                Icons.brightness_3,
                color: Colors.orange,
                size: 49.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '   Get to know your baby\'s sleep patterns and keep\n track of how much they sleep they are getting here.',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.indigo[700],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Text(
                    'Add new sleeping record',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  onPressed: () {
                    final dateProviderToForm =
                        Provider.of<DateProvider>(context, listen: false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ChangeNotifierProvider.value(
                              value: dateProviderToForm, child: DateForm());
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 80.0,
              ),
              Container(
                alignment: Alignment(-1.0, -1.0),
                child: Text(
                  dateProvider.currentDate.toUpperCase(),
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                elevation: 3.0,
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dateProvider.dateListHour.length,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemBuilder: (context, index) {
                    return _dateListBuilder(
                        context,
                        index,
                        dateProvider.dateListHour,
                        dateProvider.sleepTypeList,
                        dateProvider.sleepTimeList);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateListBuilder(
      BuildContext context,
      int index,
      List<String> dateListHour,
      List<String> sleepTypeList,
      List<String> sleepTimeList) {
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            dateListHour.reversed.toList()[index],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          VerticalDivider(),
        ],
      ),
      title: Text(
        sleepTypeList.reversed.toList()[index],
        style:
            TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.bold),
      ),
      subtitle: Text(sleepTimeList.reversed.toList()[index]),
    );
  }
}