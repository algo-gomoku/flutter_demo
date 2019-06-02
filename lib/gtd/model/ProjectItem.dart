import 'TodoState.dart';

class ProjectItem {
  TodoState state;
  String title;

  ProjectItem.fromJson(Map<String, dynamic> json)
      : state = getStateFromString(json['state']),
        title = json['title'];
}
