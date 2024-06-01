import 'package:flutter/material.dart';
import 'package:mytodo/main.dart';

import '../model/models.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo});
  final Todo todo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0,right: 16,top: 8,bottom: 8),
      child: AnimatedContainer(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                ),
              ],
              shape: BoxShape.rectangle,
              color: todo.completed ? Theme.of(context).colorScheme.primaryContainer : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          duration: Duration(milliseconds: 300),
          child: Material(
            type: MaterialType.transparency,
            child: ListTileTheme(
              horizontalTitleGap: 8.0,
              child: InkWell(
                onLongPress: (){
                  objectbox.deleteTodo(todo);
                },
                child: CheckboxListTile(
                  contentPadding: const EdgeInsets.only(left: 12),
                  controlAffinity: ListTileControlAffinity.leading,
                  checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  title: Text(todo.title,style: TextStyle(fontWeight: FontWeight.w500),),
                  value: todo.completed,
                  onChanged: (bool? value) {
                    todo.completed = value!;
                    objectbox.updateTodo(todo);
                  },
                ),
              ),
            ),
          )
      ),
    );
  }
}
