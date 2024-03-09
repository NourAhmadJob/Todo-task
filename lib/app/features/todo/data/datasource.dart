import 'package:hive/hive.dart';
import 'package:todotask/app/features/todo/domain/entites.dart';
import 'package:todotask/core/enum/todo_state.dart';
import 'package:uuid/uuid.dart';

abstract class BaseDataSource {
  Future<void> addTodo(Todo todo);

  Future<List<Todo>> getTodos();

  Future<Todo> getTodo(String id);

  Future<void> updateTodo(Todo todo);

  Future<void> deleteTodo(String id);
}

class LocalDataSource extends BaseDataSource {
  final Box todoBox;

  LocalDataSource({required this.todoBox});

  @override
  Future<void> addTodo(Todo todo) async {
    final id = Uuid().v4();
    return await todoBox.put(id, {
      'title': todo.title,
      'stateOfTodo' : todo.stateOfTodo,
      'description': todo.description,
      'id': id,
    });
  }

  @override
  Future<void> deleteTodo(id) async {
    return await todoBox.delete(id);
  }

  @override
  Future<Todo> getTodo(id) async {
    return await todoBox.get(id);
  }

  @override
  Future<List<Todo>> getTodos() async {
    List<Todo> newList = [];
    for (var element in todoBox.values) {
      newList.add(Todo(
          id: element['id'],
          title: element['title'],
          description: element['description'],
          stateOfTodo: element['stateOfTodo']));
    }
    return newList;
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    return await todoBox.put(todo.id, {
      'title': todo.title,
      'description': todo.description,
      'id': todo.id,
      'stateOfTodo': todo.stateOfTodo,
    });
  }
}
