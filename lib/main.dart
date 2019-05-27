// Flutter code sample for material.AppBar.actions.1

// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(FrendlychatApp());

final ThemeData kIOSTheme = new ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.green[100],
    primaryColorBrightness: Brightness.light);

final ThemeData kDefaultTheme = new ThemeData(
    primarySwatch: Colors.purple, accentColor: Colors.orangeAccent[400]);

TargetPlatform getPlatform(BuildContext context) {
  return Theme.of(context).platform;
//  return TargetPlatform.iOS;
}

bool isIos(BuildContext context) => getPlatform(context) == TargetPlatform.iOS;

class FrendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Friendlychat",
      home: new ChatScreen(),
      theme: isIos(context) ? kIOSTheme : kDefaultTheme,
    );
    ;
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Friendlychat"),
        elevation: isIos(context) ? 0.0 : 4.0,
      ),
      body: Container(
          child: new Column(
            children: <Widget>[
              new Flexible(
                  child: new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              )),
              new Divider(height: 1.0),
              new Container(
                  decoration:
                      new BoxDecoration(color: Theme.of(context).cardColor),
                  child: _buildTextComposer())
            ],
          ),
          decoration: isIos(context)
              ? new BoxDecoration(
                  border:
                      new Border(top: new BorderSide(color: Colors.grey[200])))
              : null),
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(color: Theme.of(context).accentColor),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              new Flexible(
                  child: new TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _handSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              )),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: isIos(context)
                    ? new CupertinoButton(
                        child: new Text("Send"),
                        onPressed: onPressed(),
                      )
                    : new IconButton(
                        icon: new Icon(Icons.send), onPressed: onPressed()),
              )
            ],
          ),
        ));
  }

  Function onPressed() {
    return _isComposing ? () => _handSubmitted(_textController.text) : null;
  }

  void _handSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
          vsync: this, duration: new Duration(milliseconds: 700)),
    );

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}

const String _name = "Jinux";

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});

  final AnimationController animationController;
  final String text;

  @override
  Widget build(BuildContext context) {
    return new FadeTransition(
      opacity:
          CurvedAnimation(parent: animationController, curve: Curves.easeIn),
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.only(right: 16.0),
              child: new CircleAvatar(
                child: new Text(_name[0]),
              ),
            ),
            Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(_name,
                      style: Theme.of(context).textTheme.subhead,
                      softWrap: true),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(text, softWrap: true),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
