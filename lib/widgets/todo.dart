import 'package:flutter/material.dart';

import 'package:todo/constants/colors.dart';
import 'package:todo/model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDO toDO;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem(
      {super.key, required this.toDO, this.onToDoChanged, this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ListTile(
            onTap: () {
              onToDoChanged(toDO);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            tileColor: Colors.white,
            leading: Icon(
              toDO.isDone
                  ? Icons.check_box
                  : Icons.check_box_outline_blank_outlined,
              color: tdBlue,
            ),
            title: Text(
              toDO.toDoText,
              style: TextStyle(
                  fontSize: 19,
                  color: tdBlack,
                  decoration: toDO.isDone ? TextDecoration.lineThrough : null),
            ),
            trailing: Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: tdRed, borderRadius: BorderRadius.circular(5)),
              child: IconButton(
                onPressed: () {
                  onDeleteItem(toDO.id);
                  // print("Delete also works properly");
                },
                iconSize: 18,
                icon: const Icon(Icons.delete),
                color: Colors.white,
              ),
            )));
  }
}
