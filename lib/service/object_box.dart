import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../model/models.dart';
import '../model/objectbox.g.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  /// Box of todos.
  late final Box<Todo> _todoBox;

  /// Getter for _todoBox
  Box<Todo> get todoBox => _todoBox;

  ObjectBox._create(this.store) {
    _todoBox = Box<Todo>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "default"));
    return ObjectBox._create(store);
  }

  Stream<List<Todo>> getTodos() {
    // Query for all todos, sorted by their date.
    final builder =
    _todoBox.query().order(Todo_.creationDate, flags: Order.descending);
    // Build and watch the query,
    // set triggerImmediately to emit the query immediately on listen.
    return builder.watch(triggerImmediately: true)
    // Map it to a list of notes to be used by a StreamBuilder.
        .map((query) => query.find());
  }

  Future<void> addTodo(Todo todo) => _todoBox.putAsync(todo);
  int todoCount() => _todoBox.count();

  Future<void> updateTodo(Todo todo) => _todoBox.putAsync(todo);

  Future<void> deleteTodo(Todo todo) => _todoBox.removeAsync(todo.id);


}
