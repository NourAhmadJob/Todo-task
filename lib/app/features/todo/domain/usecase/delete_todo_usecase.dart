import 'package:dartz/dartz.dart';
import 'package:todotask/app/features/todo/domain/usecase/get_toto_usecase.dart';
import 'package:todotask/core/base/base_usecase.dart';
import 'package:todotask/core/error/failure.dart';
import '../repository.dart';

class DeleteTodoUseCase extends BaseUseCase <void , StringIdParameter>{
  final BaseTodoRepository baseTodoRepository ;

  DeleteTodoUseCase({required this.baseTodoRepository});

  @override
  Future<Either<Failure , void>> call (StringIdParameter stringIdParameter) async {
    return await baseTodoRepository.deleteTodo(stringIdParameter.idTodo);
  }
}