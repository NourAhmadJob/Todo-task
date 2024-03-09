import 'package:dartz/dartz.dart';
import 'package:todotask/app/features/todo/domain/entites.dart';
import 'package:todotask/core/error/failure.dart';

abstract class BaseTodoRepository {
  Future<Either<Failure,List<Todo>>> getTodos();
  Future<Either<Failure , Todo>> getTodo(String id);
  Future<Either<Failure , void>> addTodo(Todo todo);
  Future<Either<Failure ,void>> updateTodo(Todo todo);
  Future<Either<Failure , void>> deleteTodo(String id);
}
