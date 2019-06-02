import 'package:flutter/material.dart';

import 'api/ming_server.dart';
import 'model/ProjectItem.dart';

class ProjectListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProjectListScreenState();
  }
}

class ProjectListScreenState extends State<ProjectListScreen> {
  List<ProjectItem> _items = [];

  @override
  void initState() {
    super.initState();
    requestProjects((items) => setState(() {
          _items = items;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => ProjectListItem(_items[index]),
        separatorBuilder: (context, index) => Divider(
              color: Colors.grey[200],
            ),
        itemCount: _items.length);
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
