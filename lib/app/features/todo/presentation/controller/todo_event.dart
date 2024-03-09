

import 'package:equatable/equatable.dart';
import 'package:todotask/app/features/todo/domain/entites.dart';
import 'package:todotask/app/features/todo/domain/usecase/get_toto_usecase.dart';

abstract class TodoEvents extends Equatable {}

class AddTodoEvent extends TodoEvents {
  final Todo todo ;

  AddTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class GetTodosEvent extends TodoEvents {
  @override
  List<Object?> get props => [];
}

class DeleteTodoEvent extends TodoEvents {
  final StringIdParameter stringIdParameter;

  DeleteTodoEvent({required this.stringIdParameter});

  @override
  List<Object?> get props => [stringIdParameter];
}

class UpdateTodoEvent extends TodoEvents {
  final Todo todo ;

  UpdateTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class GetTodoEvent extends TodoEvents {
  final StringIdParameter stringIdParameter;

  GetTodoEvent({required this.stringIdParameter});

  @override
  List<Object?> get props => [stringIdParameter];
}
