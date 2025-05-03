import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:trialtodo/login_screen.dart';
import 'package:trialtodo/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Todo> todoBox;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoBox = Hive.box<Todo>("todo");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text("انجز"),
      ),
      body: ValueListenableBuilder(
          valueListenable: todoBox.listenable(),
          builder: (context, box, _) {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                Todo todo = box.getAt(index)!;
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: todo.isCompleted
                          ? const Color.fromARGB(151, 255, 255, 255)
                          : const Color.fromARGB(243, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10)),
                  child: Dismissible(
                    key: Key(todo.dateTime.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        todo.delete();
                      });
                    },
                    child: ListTile(
                      title: Text(todo.title),
                      subtitle: Text(todo.description),
                      trailing: Text(
                        DateFormat.yMMMd().format(todo.dateTime),
                      ),
                      leading: Checkbox(
                          value: todo.isCompleted,
                          onChanged: (value) {
                            setState(() {
                              todo.isCompleted = value!;
                              todo.save();
                            });
                          }),
                    ),
                  ),
                );
              },
            );
          }),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: () {
              _addTodoDialog(context);
            },
            child: Icon(Icons.add),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen())))
        ],
      ),
    );
  }

  void _addTodoDialog(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("اضف مهمة"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: "اسم المهمه"),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: "الوصف"),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("الغاء"),
                ),
                TextButton(
                    onPressed: () {
                      _addTodo(
                          _titleController.text, _descriptionController.text);
                      Navigator.pop(context);
                    },
                    child: Text("إضافة"))
              ],
            ));
  }

  void _addTodo(String title, String Description) {
    if (title.isNotEmpty) {
      todoBox.add(Todo(
          title: title, description: Description, dateTime: DateTime.now()));
    }
  }
}
