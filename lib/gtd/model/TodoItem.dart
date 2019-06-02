import 'TodoState.dart';

class TodoItem {
  final String title;
  final TodoState state;
  final List<String> tags;

  TodoItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        state = getStateFromString(json['state']),
        tags = json['tags'].cast<String>();
}


