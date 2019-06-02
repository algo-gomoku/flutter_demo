import 'dart:convert';

import 'dart:io';

void requestTodayTodos(Function fun) async {
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
  fun(jsonResponse);
}
