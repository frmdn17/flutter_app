import 'package:flutter/material.dart';
import 'todo.dart';
import 'dart:async';
import 'DBHelper.dart';

class TodoScreen extends StatefulWidget {
  final String title;

  TodoScreen({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _TodoScreen();
  }

}

class _TodoScreen extends State<TodoScreen> {

  Future<List<Todo>> todos;
  TextEditingController nameController = TextEditingController();
  TextEditingController overviewController = TextEditingController();
  String name, overview;
  int id;

  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      todos = dbHelper.getTodos();
    });

  }

  clearName() {
    nameController.text = '';
    overviewController.text = '';
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        Todo todo = Todo(id, name, overview);
        dbHelper.update(todo);
        setState(() {
          isUpdating = false;
        });
      } else {
        Todo todo = Todo(null, name, overview);
        dbHelper.save(todo);
      }
      clearName();
      refreshList();
    }
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (val) => val.length == 0 ? 'What Do You Want?' : null,
              onSaved: (val) => name = val,
            ),
            TextFormField(
              controller: overviewController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Overview'),
              validator: (val) => val.length == 0 ? 'Tell Me The Reason' : null,
              onSaved: (val) => overview = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: validate,
                  child: Text(isUpdating ? 'Update Todo' : 'Add Todo'),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    clearName();
                  },
                  child: Text('Cancel'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  SingleChildScrollView dataTable(List<Todo> todos) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          columns: [
            DataColumn(
              label: Text('Todo'),
            ),
            DataColumn(
              label: Text('Overview'),
            ),
            DataColumn(
              label: Text('Action'),
            )
          ],
          rows: todos.map((todo) =>
              DataRow(cells: [
                DataCell(
                    Text(todo.name),
                    onTap: () {
                      setState(() {
                        isUpdating = true;
                        id = todo.id;
                      });
                      nameController.text = todo.name;
                    }
                ),
                DataCell(
                    Text(todo.overview),
                    onTap: () {
                      setState(() {
                        isUpdating = true;
                        id = todo.id;
                      });
                      overviewController.text = todo.overview;
                    }
                ),
                DataCell(IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    dbHelper.delete(todo.id);
                    refreshList();
                  },
                 )
                )
             ]),
           ).toList()
        ),
     );
  }

  list() {
    return Expanded(
      child: FutureBuilder(
          future: todos,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              if (snapshot.hasData) {
                return dataTable(snapshot.data);
              }
              if (null == snapshot.data || snapshot.data.length == 0) {
                return Text("Empty Todo :(");
              }
            }
              return CircularProgressIndicator();
         }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Screen'),
      ),
      body: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              form(),
              list(),
            ],
          )
      ),
    );
  }
}