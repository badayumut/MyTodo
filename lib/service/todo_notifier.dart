import 'package:flutter/cupertino.dart';

import '../model/models.dart';

class TodoNotifier extends ChangeNotifier {
  List<Todo> _todos = [];
  Map<String, List<Todo>> _categorizedTodos = {
    'completed': [],
    'notCompleted': [],
  };

  List<Todo> get todos => _todos;
  Map<String, List<Todo>> get categorizedTodos => _categorizedTodos;

  set todos(List<Todo> updatedtodos) {
    _todos = updatedtodos;
    _categorizedTodos = categorizeTodos();
    notifyListeners();
  }

  Map<String, List<Todo>> categorizeTodos() {
    return {
      'completed': _todos.where((todo) => todo.completed).toList(),
      'notCompleted': _todos.where((todo) => !todo.completed).toList(),
    };
  }
}