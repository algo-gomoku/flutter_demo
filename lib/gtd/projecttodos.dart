import 'package:flutter/material.dart';
import 'package:Orgtd/gtd/todo.dart';

import 'api/ming_server.dart';
import 'model/ProjectItem.dart';
import 'model/TodoItem.dart';

class ProjectTodoListScreen extends StatefulWidget {
  String title;

  ProjectTodoListScreen({Key key, @required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProjectTodoListScreenState(title);
  }
}

class ProjectTodoListScreenState extends State<ProjectTodoListScreen> {
  List<TodoItem> _items = [];
  String title;

  ProjectTodoListScreenState(this.title);

  @override
  void initState() {
    super.initState();
    requestProjectTodos(
        title,
        (items) => setState(() {
              _items = items;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title TODOS"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => TodoListItemView(_items[index]),
          separatorBuilder: (context, index) => Divider(
                color: Colors.grey[200],
              ),
          itemCount: _items.length),
    );
  }
}

class ProjectListItem extends StatelessWidget {
  ProjectListItem(this.item);

  ProjectItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        item.title,
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
    );
  }
}
