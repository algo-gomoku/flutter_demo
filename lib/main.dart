// Flutter code sample for material.AppBar.actions.1

// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat/ChatScreen.dart';
import 'gtd/todo.dart';
import 'platformutils.dart';

void main() => runApp(DemoApp());

final ThemeData kIOSTheme = new ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.green[100],
    primaryColorBrightness: Brightness.light);

final ThemeData kDefaultTheme = new ThemeData(
    primarySwatch: Colors.purple, accentColor: Colors.orangeAccent[400]);


class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo",
      home: new HomeScreen(),
      theme: isIos(context) ? kIOSTheme : kDefaultTheme,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }

}

class HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;
  final List<Widget> _widgets = <Widget>[
    TodayTodoScreen(showAppBar: false,), Text("hello")
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Main"),
        elevation: isIos(context) ? 0.0 : 4.0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(height: 40,),
            ListTile(
              title: Text("chat demo"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => new ChatScreen())),
            ),
            ListTile(
              title: Text("Todo"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => new TodayTodoScreen(showAppBar: true,))),
            )
          ],
        ),
      ),
      body: _widgets[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.today),
              title: Text("TODO")
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text("settings")
          )
        ],
      ),
    );
  }

  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

}




