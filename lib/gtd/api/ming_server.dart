import 'dart:convert';
import 'dart:io';

import 'package:Orgtd/gtd/model/ProjectItem.dart';
import 'package:Orgtd/gtd/model/TodoItem.dart';

final String _HOST = "118.89.57.250";

void requestTodos(String date, Function fun) async {
  print(date);
  dynamic jsonResult = await _requestJson('/api/todos', true, {"date": date});
  if (jsonResult == null) {
    return;
  }

  List<dynamic> list = jsonResult['data'];
  List<TodoItem> items = list.map((item) => TodoItem.fromJson(item)).toList();

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
  List<TodoItem> items = list.map((item) => TodoItem.fromJson(item)).toList();

  fun(items);
}

void requestTodoDetail(String name, Function fun) async {
  dynamic jsonResult = await _requestJson('/api/todos/$name/');
  if (jsonResult == null) {
    return;
  }

  TodoItem item = TodoItem.fromJson(jsonResult['data']);

  fun(item);
}

void requestPostTodoAction(String name, String action, Function fun) async {
  dynamic jsonResult =
  await _requestJson(
      '/orgtd/api/todos/detail/', false, {"_title": name, "action": action});
  if (jsonResult == null) {
    return;
  }
  print(jsonResult);
  TodoItem item = TodoItem.fromJson(jsonResult['data']);

  fun(item);
}

dynamic _requestJson(String urlPath,
    [bool isGetMethod = true, Map<String, String> queryParameters]) async {
  final uri = Uri.http(_HOST, urlPath, queryParameters);
  print(uri);
  final httpClient = HttpClient();
  HttpClientRequest httpRequest;
  if (isGetMethod) {
    final uri = Uri.http(_HOST, urlPath, queryParameters);
    print(uri);
    httpRequest = await httpClient.getUrl(uri);
  } else {
    final uri = Uri.http(_HOST, urlPath);
    print(uri);
    httpRequest = await httpClient.postUrl(uri);
    httpRequest.headers.add("content-type", "application/json");
    String str = json.encode(queryParameters);
    httpRequest.add(utf8.encode(str));
  }
  final httpResponse = await httpRequest.close();
  if (httpResponse.statusCode != HttpStatus.ok) {
    print(httpResponse.statusCode);
    return null;
  }

  final responseBody = await httpResponse.transform(utf8.decoder).join();
  final jsonResponse = json.decode(responseBody);
  print(jsonResponse);
  return jsonResponse;
}
