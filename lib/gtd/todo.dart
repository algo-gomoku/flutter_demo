import 'package:Orgtd/gtd/tododetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:intl/intl.dart';

import 'api/ming_server.dart';
import 'model/TodoItem.dart';
import 'model/TodoState.dart';

class TodayTodoScreen extends StatefulWidget {
  TodayTodoScreen({this.showAppBar});

  bool showAppBar;

  @override
  State<StatefulWidget> createState() {
    return TodayTodoScreenState(showAppBar);
  }
}

class TodayTodoScreenState extends State<TodayTodoScreen> {
  TodayTodoScreenState(this.showAppBar);

  bool showAppBar = true;
  List<TodoItem> todoItems = [];
  Calendar calendar;

  @override
  void initState() {
    super.initState();
    calendar = new Calendar(
      isExpandable: true,
      onDateSelected: onDateSelect,
    );
    requestTodos(
        fmtDate(DateTime.now()),
        (items) => setState(() {
              todoItems = items;
            }));
  }

  void onDateSelect(DateTime date) {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: showAppBar ? AppBar(title: Text("Todo")) : null,
      body: Column(
        children: <Widget>[
          new Calendar(
            isExpandable: true,
            onDateSelected: (date) => requestTodos(
                fmtDate(date),
                (items) => setState(() {
                      todoItems = items;
                    })),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return TodoListItemView(todoItems[index]);
              },
              separatorBuilder: (context, index) => Divider(
                    color: Colors.grey[200],
                  ),
              itemCount: todoItems.length,
            ),
          )
        ],
      ),
    );
  }

  String fmtDate(DateTime date) {
    final format = DateFormat("yyyy-MM-dd");
    return format.format(date);
  }
}

class TodoListItemView extends StatelessWidget {
  TodoListItemView(this.item);

  final TodoItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.title,
        style: getTextColor(),
      ),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TodoDetailScreen(title: item.title))),
    );
  }

  TextStyle getTextColor() {
    Color color;
    switch (item.state) {
      case TodoState.CLOCKING:
        color = Colors.lightGreenAccent;
        break;
      case TodoState.DONE:
        color = Colors.green;
        break;
      case TodoState.DELAY:
        color = Colors.redAccent;
        break;
      default:
        color = Colors.black;
    }
    return TextStyle(color: color);
  }

  void onItemTap() {}
}
