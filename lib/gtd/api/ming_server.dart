import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/gtd/model/ProjectItem.dart';
import 'package:flutter_app/gtd/model/TodoItem.dart';

final String _HOST = "118.89.57.250";

void requestTodayTodos(Function fun) async {
  dynamic jsonResult = await requestJson('/api/todos');
  if (jsonResult == null) {
    return;
  }

  List<dynamic> list = jsonResult['data'];
  List<TodoItem> items =
      list.map((item) => TodoItem.fromJson(item)).toList();

  fun(items);
}

void requestProjects(Function fun) async {

  dynamic jsonResult = await requestJson('/api/projects');
  if (jsonResult == null) {
    return;
  }

  List<dynamic> list = jsonResult['data'];
  List<ProjectItem> items =
  list.map((item) => ProjectItem.fromJson(item)).toList();

  fun(items);
}

dynamic requestJson(String urlPath) async {
  final uri = Uri.http(_HOST, urlPath, {});
  final httpClient = HttpClient();
  final httpRequest = await httpClient.getUrl(uri);
  final httpResponse = await httpRequest.close();
  if (httpResponse.statusCode != HttpStatus.ok) {
    return null;
  }

  final responseBody = await httpResponse.transform(utf8.decoder).join();
  final jsonResponse = json.decode(responseBody);
  print(jsonResponse);
  return jsonResponse;
}
