import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddTodoState();
  }
}

class AddTodoState extends State<AddTodo> {
  final _formKey = GlobalKey<FormState>();
  final todoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Todo'),
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: todoTextController,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: RaisedButton(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      child: Text(
                        'Add',
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        onAddButtonPressed(context);
                      },
                    )
                )
              ],
            ),
          ),
        ));
  }

  void onAddButtonPressed(BuildContext context) {
    if (_formKey.currentState.validate()) {
      Navigator.pop(context, todoTextController.text);
    }
  }
}
