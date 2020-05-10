import 'package:assignment2b/AddTodo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

List<String> todoItems = [];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyTodoListWidget(title: 'Todo List'),
    );
  }
}

class MyTodoListWidget extends StatefulWidget {
  final String title;

  MyTodoListWidget({Key key, this.title}) : super(key: key);

  @override
  _MyTodoListWidgetState createState() => _MyTodoListWidgetState();
}

class _MyTodoListWidgetState extends State<MyTodoListWidget> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: getBodyWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: addToDoItem,
        tooltip: 'Add item',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getBodyWidget() {
    return Container(
        child: ListView.builder(
            itemCount: todoItems.length,
            itemBuilder: (BuildContext ctx, int index) {
              return getTodoItemContainer(todoItems[index]);
            }));
  }

  Widget getTodoItemContainer(String item) {
    return InkWell(
        onLongPress: () => showMarkAsCompletedDialog(item),
        child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(item,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey,
                )
              ],
            )));
  }

  void showMarkAsCompletedDialog(String todoItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Completed"),
          content: new Text("Do you want to mark ${todoItem} completed"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                removeItem(todoItem);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addToDoItem() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTodo()),
    );
    todoItems.add(result);
  }

  void removeItem(String todoItem) {
    setState(() {
      for (String item in todoItems) {
        if (todoItem == item) {
          todoItems.remove(item);
        }
      }
    });
  }
}
