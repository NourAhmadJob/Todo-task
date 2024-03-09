// // // data/repositories/todo_repository_impl.dart
// //
// // import 'package:your_app_name/data/data_sources/hive_todo_data_source.dart';
// // import 'package:your_app_name/domain/entities/todo.dart';
// // import 'package:your_app_name/domain/repositories/todo_repository.dart';
// //
// // class TodoRepositoryImpl implements TodoRepository {
// //   final HiveTodoDataSource hiveTodoDataSource;
// //
// //   TodoRepositoryImpl(this.hiveTodoDataSource);
// //
// //   @override
// //   Future<void> addTodo(Todo todo) async {
// //     await hiveTodoDataSource.addTodo(todo);
// //   }
// //
// //   @override
// //   Future<void> deleteTodoById(String id) async {
// //     await hiveTodoDataSource.deleteTodoById(id);
// //   }
// //
// //   @override
// //   Future<List<Todo>> getAllTodos() async {
// //     return await hiveTodoDataSource.getAllTodos();
// //   }
// //
// //   @override
// //   Future<Todo> getTodoById(String id) async {
// //     return await hiveTodoDataSource.getTodoById(id);
// //   }
// //
// //   @override
// //   Future<void> updateTodo(Todo todo) async {
// //     await hiveTodoDataSource.updateTodo(todo);
// //   }
// // }
//
// // data/repositories/todo_repository_impl.dart
//
// import 'package:hive/hive.dart';
// import 'package:uuid/uuid.dart';
// import 'package:your_app_name/domain/entities/todo.dart';
// import 'package:your_app_name/domain/repositories/todo_repository.dart';
//
// class TodoRepositoryImpl implements TodoRepository {
//   final Box _todoBox;
//
//   TodoRepositoryImpl(this._todoBox);
//
//   @override
//   Future<void> addTodo({
//     String title,
//     String description,
//   }) async {
//     final String id = Uuid().v4();
//     final todo = Todo(
//       id: id,
//       title: title,
//       description: description,
//     );
//     await _todoBox.put(id, todo);
//   }
// }
//

import 'package:dartz/dartz.dart';
import 'package:todotask/app/features/todo/data/datasource.dart';
import 'package:todotask/app/features/todo/domain/entites.dart';
import 'package:todotask/app/features/todo/domain/repository.dart';
import 'package:todotask/app/features/todo/domain/usecase/get_toto_usecase.dart';
import 'package:todotask/core/constance/strings.dart';
import 'package:todotask/core/error/failure.dart';

class TodoRepositoryImp extends BaseTodoRepository {
  final BaseDataSource baseDataSource;

  TodoRepositoryImp({required this.baseDataSource});
  @override
  Future<Either<Failure, void>> addTodo(Todo todo) async {
    try {
     final result = await  baseDataSource.addTodo(todo);
     return Right(result);
    } catch(e) {
      print(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(String id)async{
    try {
      final result = await  baseDataSource.deleteTodo(id);
      return Right(result);
    } catch(error) {
      print(error.toString());
      return const Left(Failure(message: StringsManager.ERROR_HAPPEN));
    }
  }

  @override
  Future<Either<Failure, Todo>> getTodo(String id) async {
    try{
    final result = await baseDataSource.getTodo(id);
    print('hello result $result');
      return Right(result);
    }catch(error) {
      print(error.toString());
      return const Left(Failure(message: StringsManager.ERROR_HAPPEN));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async{
    try {
    final result = await baseDataSource.getTodos();
      return Right(result);
    }catch(error){
      print(error);
      return const Left(Failure(message: StringsManager.ERROR_HAPPEN));
    }

  }

  @override
  Future<Either<Failure, void>> updateTodo(Todo todo) async{
    try{
      final result = await baseDataSource.updateTodo(todo);
      return Right(result);
    }catch(error) {
      return const Left(Failure(message: StringsManager.ERROR_HAPPEN));
    }
  }
}