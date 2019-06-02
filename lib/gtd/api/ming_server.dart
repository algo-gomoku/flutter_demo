import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/gtd/model/ProjectItem.dart';
import 'package:flutter_app/gtd/model/TodoItem.dart';

final String _HOST = "118.89.57.250";

void requestTodos(String date, Function fun) async {
  print(date);
  dynamic jsonResult = await _requestJson('/api/todos', {"date": date});
  if (jsonResult == null) {
    return;
  }

  List<dynamic> list = jsonResult['data'];
  List<TodoItem> items =
      list.map((item) => TodoItem.fromJson(item)).toList();

  fun(items);
}

void requestProjects(Function fun) async {

  dynamic jsonResult = await _requestJson('/api/projects');
  if (jsonResult == null) {
    return;
  }

  List<dynamic> list = jsonResult['data'];
  List<ProjectItem> items =
  list.map((item) => ProjectItem.fromJson(item)).toList();

  fun(items);
}

void requestProjectTodos(String project, Function fun) async {

  dynamic jsonResult = await _requestJson('/api/projects/$project/todos');
  if (jsonResult == null) {
    return;
  }

  List<dynamic> list = jsonResult['data'];
  List<TodoItem> items =
  list.map((item) => TodoItem.fromJson(item)).toList();

  fun(items);
}


dynamic _requestJson(String urlPath, [Map<String, String> queryParameters]) async {
  final uri = Uri.http(_HOST, urlPath, queryParameters);
  print(uri)
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
