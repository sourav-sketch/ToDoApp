import 'package:flutter/material.dart';
import 'package:my_secondapp/constraints/colors.dart';
import 'package:my_secondapp/widgets/todo_item.dart';
import 'package:my_secondapp/model/todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo>_foundToDo =[];
  final  _todoController= TextEditingController();
@override
  void initState() {
   _foundToDo =todosList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tdYellow,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: tdGreen,
              size: 30,
            ),
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/shirt.jpg'),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color:  Color(0xFF4FFF3B),

                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    onChanged: (value)=>_runFilter(value),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(
                        Icons.search_sharp,
                        color: tdBlue,
                        size: 20,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 20,
                        minWidth: 25,
                      ),
                      border: InputBorder.none,
                      hintText: 'search',
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Text(
                          'My ToDo task',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todoo,  // Corrected spelling
                          onToDoChanged: _handleToDoChange,
                           onDeleteItem: _deleteToDoItem,  // Ensure the correct function or remove if not needed
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    child: Text('+', style: TextStyle(fontSize: 40)),
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF4FFF3B),
                      minimumSize: Size(60, 60),
                      elevation: 10, // Corrected elevation here
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


void _handleToDoChange(ToDo todo) {
  setState(() {
    todo.isDone = !todo.isDone;
  });
}
void _deleteToDoItem(String id ){
    setState(() {
      todosList.removeWhere((item) => item.id==id);
    });

}
void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));

    });
    _todoController.clear();



}
void _runFilter(String enteredKeyword){
  List<ToDo>results =[];
  if(enteredKeyword.isEmpty){
    results=todosList;
  }else {
  results=todosList.where((item)=> item.todoText!
      .toLowerCase()
      .contains(enteredKeyword.toLowerCase())).toList();

}
  setState(() {
    _foundToDo=results;
  });
}}
