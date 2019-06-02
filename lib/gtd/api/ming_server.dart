import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/gtd/model/TodoItem.dart';

final String _HOST = "118.89.57.250";

void requestTodayTodos(Function fun) async {
  final uri = Uri.http(_HOST, '/api/todos', {});
  final httpClient = HttpClient();
  final httpRequest = await httpClient.getUrl(uri);
  final httpResponse = await httpRequest.close();
  if (httpResponse.statusCode != HttpStatus.ok) {
    return;
  }

  final responseBody = await httpResponse.transform(utf8.decoder).join();
  final jsonResponse = json.decode(responseBody);
  print(jsonResponse);

  List<dynamic> list = jsonResponse['data'];
  List<TodoItem> todoItems =
      list.map((item) => TodoItem.fromJson(item)).toList();

  fun(todoItems);
}
