import 'TodoState.dart';

class TodoItem {
  final String title;
  final TodoState state;
  final List<String> tags;
  final Schedule schedule;
  final List<LogbookItem> logbook;
  bool clocking = false;

  TodoItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        state = getStateFromString(json['state']),
        tags = json['tags'].cast<String>(),
        schedule = json['schedule'] == null
            ? null
            : Schedule.fromJson(json['schedule']),
        logbook = json['logbook'] == null
            ? null
            : json['logbook']
                .map<LogbookItem>((item) => LogbookItem.fromJson(item))
                .toList(),
        clocking =
            json['clocking'] == null ? null : json['clocking'];
}

class Schedule {
  String date;
  String repeater;

  Schedule.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        repeater = json['repeater'];
}

class LogbookItem {
  String start;
  String end;
  String delta;

  LogbookItem.fromJson(Map<String, dynamic> json)
      : start = json['start'],
        end = json['end'],
        delta = json['delta'];
}
