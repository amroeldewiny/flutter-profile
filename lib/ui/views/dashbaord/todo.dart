import 'package:baobabart/core/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baobabart/core/services/Task.dart';
import 'package:baobabart/core/services/auth.dart';
import 'package:baobabart/core/models/user.dart';
import 'package:baobabart/ui/widgets/baobabtheme.dart';
import 'package:baobabart/ui/widgets/baobabappbar.dart';
import 'package:baobabart/ui/widgets/baobabdawer.dart';

class Todo extends StatefulWidget {
  final Profile profile;
  Todo({Key key, this.profile}) : super(key: key);
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
  final TaskService _task = TaskService();
  final AuthService _auth = AuthService();
  List todos = List();
  String task;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todos.add("Create database Todos");
    todos.add("Output database Todos");
    todos.add("Link Task and todos");
  }

  @override
  Widget build(BuildContext context) {
    //final tasks = Provider.of<List>(context) ?? [];

    return Scaffold(
        key: _drawerKey,
        drawer: BaobabDrawer(),
        backgroundColor: BaobabTheme.primary,
        appBar: BaobabAppBar(
          title: 'Todos',
          callback: () => _drawerKey.currentState.openDrawer(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: BaobabTheme.dark,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Add Todo'),
                    content: TextField(
                      onChanged: (String value) {
                        task = value;
                      },
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            _task.createTasks('mlsdqlfjdsqlmkjflmkqdsjmlkfj',
                                task, 'some dome description', false);
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text('Add'),
                      )
                    ],
                  );
                });
          },
          child: Icon(
            Icons.add,
            color: BaobabTheme.primary,
          ),
        ),
        body: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              if (todos.length > 0) {
                return Dismissible(
                    key: Key(todos[index]),
                    child: Card(
                      child: ListTile(
                          title: Text(todos[index]),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: () {
                              setState(() {
                                todos.removeAt(index);
                              });
                            },
                          )),
                    ));
              } else {
                return Center(
                  child: Text('Add Your First todo task'),
                );
              }
            }));
  }
}

/*class Todo extends StatelessWidget {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();

  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Todo>>.value(
      value: _db.todos,
      child: Scaffold(
        backgroundColor: BaobabTheme.primary,
        key: _drawerKey,
        drawer: BaobabDrawer(),
        appBar: BaobabAppBar(
          title: 'Todos',
          callback: () => _drawerKey.currentState.openDrawer(),
        ),
        body: Container(
          child: TodosList(),
        ),
      ),
    );
  }
}

class TodosList extends StatefulWidget {
  @override
  _TodosListState createState() => _TodosListState();
}

class _TodosListState extends State<TodosList> {
  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<List<Todo>>(context) ?? [];

    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return TodoItem(todo: todos[index]);
        });
  }
}

class TodoItem extends StatelessWidget {
  final Todo todo;
  TodoItem({this.todo});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text('todo info coming soon!!!'),
        ),
      ),
    );
  }
}*/
