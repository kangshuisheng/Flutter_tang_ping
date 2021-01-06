import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  TodoList({Key key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class TodoItemModel {
  TodoItemModel(this.id, this.content, this.isDone);
  int id;
  String content;
  bool isDone;
}

class _TodoListState extends State<TodoList> {
  List<TodoItemModel> _todos = [];
  int _id = 0;
  final _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      print(_controller.text);
    });
  }

  void _addItem(text) {
    TodoItemModel item = TodoItemModel(_id++, text, false);
    setState(() {
      _todos.add(item);
    });
  }

  void _upDateitem(index) {}

  void _delItem(index) {
    setState(() {
      _todos.remove(_todos[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextField(
            controller: _controller,
            onSubmitted: (value) {
              _addItem(value);
              _controller.text = '';
            }),
        Column(
            children: List.generate(
          _todos.length,
          (i) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                  value: _todos[i].isDone,
                  onChanged: (nvalue) {
                    setState(() {
                      _todos[i].isDone = nvalue;
                    });
                  }),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _todos[i].isDone = !_todos[i].isDone;
                  });
                },
                child: Text(_todos[i].content),
              ),
              InkWell(
                onTap: () => _delItem(i),
                child: Icon(_todos[i].isDone ? Icons.delete : null),
              )
            ],
          ),
        )),
      ],
    ));
  }
}
