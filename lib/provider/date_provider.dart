import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class DateProvider with ChangeNotifier {
  String  _currentDate;
  List<String> _dateListHour;
  List<String> _sleepTypeList;
  List<String> _sleepTimeList;

  DateProvider() {
    _currentDate = '';
    _dateListHour = List<String>();
    _sleepTypeList = List<String>();
    _sleepTimeList = List<String>();
    setCurrentDate();
  }

  String get currentDate => _currentDate;
  List<String> get dateListHour => _dateListHour;
  List<String> get sleepTypeList => _sleepTypeList;
  List<String> get sleepTimeList => _sleepTimeList;

  void setCurrentDate(){
    DateTime now = DateTime.now();
    _currentDate = DateFormat('EEEE, d MMM y').format(now);
    notifyListeners();
  }

  void setDateListHour(String dateListHourAndMinute) {
    _dateListHour.add(dateListHourAndMinute);
    notifyListeners();
  }

  void setSleepType(String sleepType) {
    _sleepTypeList.add(sleepType);
    notifyListeners();
  }

  void setSleepTime(String sleepTime) {
    _sleepTimeList.add(sleepTime);
  }
}