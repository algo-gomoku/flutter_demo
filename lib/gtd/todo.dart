import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class TodayTodoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodayTodoScreenState();
  }
}

class TodayTodoScreenState extends State<TodayTodoScreen> {
  List<dynamic> todoItems = [];

  @override
  void initState() {
    super.initState();
    requestTodayTodos();
  }

  void requestTodayTodos() async {
    final uri = Uri.http("118.89.57.250", '/api/todos', {});
    final httpClient = HttpClient();
    final httpRequest = await httpClient.getUrl(uri);
    final httpResponse = await httpRequest.close();
    if (httpResponse.statusCode != HttpStatus.ok) {
      return;
    }

    final responseBody = await httpResponse.transform(utf8.decoder).join();
    final jsonResponse = json.decode(responseBody);
    print(jsonResponse);
    setState(() {
      todoItems = jsonResponse['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          print(todoItems[index]);
          return TodoListItemView(TodoItem.fromJson(todoItems[index]));
        },
        separatorBuilder: (context, index) => Divider(
              color: Colors.grey[200],
            ),
        itemCount: todoItems.length,
      ),
    );
  }
}

class TodoListItemView extends StatelessWidget {
  TodoListItemView(this.item);

  final TodoItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(item.title),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
    );
  }
}

class TodoItem {
  final String title;
  final String state;
  final List<String> tags;

  TodoItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        state = json['state'],
        tags = json['tags'].cast<String>();
}
