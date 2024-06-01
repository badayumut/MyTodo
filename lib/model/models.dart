import 'package:objectbox/objectbox.dart';

@Entity()
class Todo {
  @Id(assignable: true)
  int id = DateTime.now().millisecondsSinceEpoch;

  String title;

  @Index()
  DateTime creationDate;


  @Index()
  bool completed = false;

  Todo({
    required this.title,
    required this.creationDate,
  });
}