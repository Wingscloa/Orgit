import 'package:flutter/material.dart';
import '../../models/todo.dart';
import '../../services/api/todo.dart';
import 'package:orgit/global_vars.dart';

class Todolistpage extends StatefulWidget {
  @override
  _TodolistpageState createState() => _TodolistpageState();
}

class _TodolistpageState extends State<Todolistpage> {
  List<Todo> todos = [];
  bool isLoading = true;
  final int userId = 1; // This should come from authenticated user

  // Future<void> _loadTodos() async {}

  // Future<void> _addTodo() async {}
  @override
  void initState() {
    super.initState();
    // _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.background, // Dark background
      body: SafeArea(
        child: Stack(
          children: [
            // sticky add button
            Positioned(
              bottom: 30,
              right: 20,
              child: GestureDetector(
                onTap: () => throw UnimplementedError(
                    "Add Todo functionality not implemented yet"),
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: Color.fromARGB(255, 255, 203, 105),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'ToDo List',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (todos.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        Image(
                          height: 350,
                          width: 400,
                          image: AssetImage("assets/todoEmpty.png"),
                        ),
                        Text(
                          'Prázdný',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 105, 106, 108),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Nemáš žádné úkoly',
                          style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 105, 106, 108),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => throw UnimplementedError(
                              "Add Todo functionality not implemented yet"),
                          child: Container(
                            width: 200,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 203, 105),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              // Removed 'spacing: 5,' as Row does not have a spacing property
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                                Text(
                                  "Přidat nový úkol",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
