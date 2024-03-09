import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todotask/app/features/todo/domain/entites.dart';
import 'package:todotask/core/base/base_usecase.dart';
import 'package:todotask/core/error/failure.dart';
import '../repository.dart';

class GetTodoUseCase extends BaseUseCase<Todo ,StringIdParameter>{
  final BaseTodoRepository baseTodoRepository ;

  GetTodoUseCase({required this.baseTodoRepository});

  @override
  Future<Either<Failure, Todo>> call(parameter) async{
    return await baseTodoRepository.getTodo(parameter.idTodo);
  }
}

class StringIdParameter extends Equatable {
  final String idTodo ;

  const StringIdParameter({required this.idTodo});

  @override
  List<Object?> get props => [idTodo];
}