import 'package:dartz/dartz.dart';
import 'package:todotask/app/features/todo/data/datasource.dart';
import 'package:todotask/app/features/todo/domain/entites.dart';
import 'package:todotask/app/features/todo/domain/repository.dart';
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
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(String id)async{
    try {
      final result = await  baseDataSource.deleteTodo(id);
      return Right(result);
    } catch(error) {
      return const Left(Failure(message: StringsManager.ERROR_HAPPEN));
    }
  }

  @override
  Future<Either<Failure, Todo>> getTodo(String id) async {
    try{
    final result = await baseDataSource.getTodo(id);
      return Right(result);
    }catch(error) {
      return const Left(Failure(message: StringsManager.ERROR_HAPPEN));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async{
    try {
    final result = await baseDataSource.getTodos();
      return Right(result);
    }catch(error){
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