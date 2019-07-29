import 'package:flutter/material.dart';

class EditPostScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _EditPostScrenn();

}

class _EditPostScrenn extends State<EditPostScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Post')
      ),
      body: new Container(
        padding: EdgeInsets.all(8.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextField(
              decoration: InputDecoration(
                hintText: "Title",
              ),
            ),
            new TextField(
              decoration: InputDecoration(
                hintText: "Overview",
              ),
            )
          ],
        ),
      ),
    );
  }
}