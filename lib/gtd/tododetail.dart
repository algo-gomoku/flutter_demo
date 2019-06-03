import 'package:flutter/material.dart';

import 'api/ming_server.dart';
import 'model/TodoItem.dart';
import 'model/TodoState.dart';

class TodoDetailScreen extends StatefulWidget {
  String title;

  TodoDetailScreen({Key key, @required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TodoDetailScreenState(title);
  }
}

class TodoDetailScreenState extends State<TodoDetailScreen> {
  TodoItem _item;
  String title;

  TodoDetailScreenState(this.title);

  @override
  void initState() {
    super.initState();
    requestTodoDetail(
        title,
        (item) => setState(() {
              _item = item;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title"),
      ),
      body: _item == null
          ? Center(
              child: Text("Loading..."),
            )
          : buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        buildClockControlPanel(_item),
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                    title: Text(_item.logbook[index].start),
                  ),
              separatorBuilder: (context, index) => Divider(
                    color: Colors.grey[200],
                  ),
              itemCount: _item.logbook.length),
        ),
      ],
    );
  }

  Widget buildClockControlPanel(TodoItem item) {
    return Row(
      children: <Widget>[
        item.clocking
            ? IconButton(
                icon: Icon(
                  Icons.pause,
                  color: Colors.red,
                ),
                onPressed: () => requestPostTodoAction(
                    item.title,
                    'clock out',
                    (item) => setState(() {
                          _item = item;
                        })),
              )
            : IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  color: Colors.green,
                ),
                onPressed: () => requestPostTodoAction(
                    item.title,
                    'clock in',
                    (item) => setState(() {
                          _item = item;
                        })),
              ),
        IconButton(
          icon: Icon(
            Icons.done,
            color: item.state == TodoState.DONE ? Colors.green : Colors.grey,
          ),
          onPressed: () => {},
        ),
      ],
    );
  }
}
