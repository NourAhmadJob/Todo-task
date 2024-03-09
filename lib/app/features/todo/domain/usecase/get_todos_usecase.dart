import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todotask/app/features/todo/domain/entites.dart';
import 'package:todotask/core/base/base_usecase.dart';
import 'package:todotask/core/error/failure.dart';
import '../repository.dart';

class GetTodosUseCase extends BaseUseCase <List<Todo> , NoParameter>{
  final BaseTodoRepository baseTodoRepository ;

  GetTodosUseCase({required this.baseTodoRepository});

  @override
  Future<Either<Failure , List<Todo>>> call(NoParameter parameter) async {
    return await baseTodoRepository.getTodos();
  }
}

class NoParameter extends Equatable {
  const NoParameter();
  @override

  List<Object?> get props => [];

}