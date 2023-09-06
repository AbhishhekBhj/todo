import 'package:flutter/material.dart';
import 'package:todo/widgets/todo.dart';
import '../constants/colors.dart';
import '../model/todo.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDO.toDoList();
  final _toDoController = TextEditingController();
  List<ToDO> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todoList;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBgColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          "My ToDo's",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                      for (ToDO toDO in todoList)
                        ToDoItem(
                          toDO: toDO,
                          onToDoChanged: _handleToDoChanges,
                          onDeleteItem: _deleteToDoItem,
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin:
                      const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _toDoController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add new ToDO Here"),
                  ),
                )),
                Container(
                  height: 60,
                  width: 60,
                  margin: const EdgeInsets.only(bottom: 30, right: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: tdBlue,
                        minimumSize: const Size(60, 60),
                        elevation: 10),
                    onPressed: () {
                      _addToDoItem(_toDoController.text);
                    },
                    child: const Text("+", style: TextStyle(fontSize: 30)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChanges(ToDO toDO) {
    setState(() {
      toDO.isDone = !toDO.isDone;
    });
  }

  //delete to do
  void _deleteToDoItem(String id) {
    setState(() {
      //find id and delete element with that id
      todoList.removeWhere((element) => element.id == id);
    });
  }

  //add to do

  void _addToDoItem(String toDo) {
    //set id as the time stampp converting to string
    setState(() {
      todoList.add(ToDO(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          toDoText: toDo));
    });
    //clear after adding to do item
    _toDoController.clear();
  }

  void _runFilter(String keyword) {
    List<ToDO> results = [];
    if (keyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((element) =>
              element.toDoText.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: TextField(
          onChanged: (value) => _runFilter(value),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(
                Icons.search,
                color: tdBlack,
                size: 20,
              ),
              prefixIconConstraints:
                  BoxConstraints(maxHeight: 20, minWidth: 25),
              border: InputBorder.none,
              hintText: "Search To Do's Here",
              hintStyle: TextStyle(color: tdGrey))),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBgColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
          ),
          Container(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                    "https://play-lh.googleusercontent.com/HUuQc4Zpl6x7fUyX-jFMmcuUbW77REw4UKl5rfhHfP4VY6ctBU1w1I_RZWsXaojFgIo"),
              ))
        ],
      ),
    );
  }
}
