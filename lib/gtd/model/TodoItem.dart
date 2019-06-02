class TodoItem {
  final String title;
  final TodoState state;
  final List<String> tags;

  TodoItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        state = getStateFromString(json['state']),
        tags = json['tags'].cast<String>();

  static TodoState getStateFromString(state) {
    switch (state) {
      case "DONE":
        return TodoState.DONE;
      case "DELAY":
        return TodoState.DELAY;
      case "CLOCKING":
        return TodoState.CLOCKING;
    }
  }
}

enum TodoState { DONE, DELAY, CLOCKING }
