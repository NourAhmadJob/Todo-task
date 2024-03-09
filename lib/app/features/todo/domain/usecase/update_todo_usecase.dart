import 'package:dartz/dartz.dart';
import 'package:todotask/app/features/todo/domain/entites.dart';
import 'package:todotask/core/base/base_usecase.dart';
import 'package:todotask/core/error/failure.dart';
import '../repository.dart';

class UpdateTodoUseCase extends BaseUseCase<void , Todo>{
  final BaseTodoRepository baseTodoRepository ;

  UpdateTodoUseCase({required this.baseTodoRepository});

  @override
  Future<Either<Failure , void>> call (Todo todo) async {
    return await baseTodoRepository.updateTodo(todo);
  }
}