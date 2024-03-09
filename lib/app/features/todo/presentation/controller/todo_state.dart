// part of 'todo_bloc.dart';
//
// @immutable
// abstract class TodoState {}
//
// class TodoInitial extends TodoState {}

import 'package:equatable/equatable.dart';
import 'package:todotask/app/features/todo/domain/entites.dart';
import 'package:todotask/core/enum/process_state.dart';
import 'package:todotask/core/enum/todo_state.dart';

class TodoStates extends Equatable {
  // add todo
  final ProcessState addTodoState;
  final String addTodoMessage;

  // get todos
  final ProcessState getTodosState;
  final List<Todo> getTodos;
  final String getTodosMessage;

  // get todo
  final ProcessState getTodoState;
  final String getTodoMessage;

  // update todo
  final ProcessState updateTodoState;
  final String updateTodoMessage;

  // delete todo
  final ProcessState deleteTodoState;
  final String deleteTodoMessage;

  // states
  final StateOfTodo stateOfTodo;
  final List<String> idOfStateTodo;

  const TodoStates({
    this.addTodoState = ProcessState.initial,
    this.addTodoMessage = '',
    this.getTodos = const [],
    this.getTodosState = ProcessState.initial,
    this.getTodosMessage = '',
    this.deleteTodoMessage = '',
    this.deleteTodoState = ProcessState.initial,
    this.updateTodoMessage = '',
    this.updateTodoState = ProcessState.initial,
    this.getTodoMessage = '',
    this.getTodoState = ProcessState.initial,

    this.stateOfTodo = StateOfTodo.initial,
    this.idOfStateTodo = const [],
  });

  TodoStates copyWith(
      {ProcessState? addTodoState,
      String? addTodoMessage,
      ProcessState? getTodosState,
      List<Todo>? getTodos,
      String? getTodosMessage,
      ProcessState? deleteTodoState,
      String? deleteTodoMessage,
      ProcessState? updateTodoState,
      String? updateTodoMessage,
      ProcessState? getTodoState,
      String? getTodoMessage,
      StateOfTodo? stateOfTodo,
        List<String>? idOfStateTodo,
      }) {
    return TodoStates(
      addTodoState: addTodoState ?? this.addTodoState,
      addTodoMessage: addTodoMessage ?? this.addTodoMessage,
      getTodos: getTodos ?? this.getTodos,
      getTodosState: getTodosState ?? this.getTodosState,
      getTodosMessage: getTodosMessage ?? this.getTodosMessage,
      deleteTodoMessage: deleteTodoMessage ?? this.deleteTodoMessage,
      deleteTodoState: deleteTodoState ?? this.deleteTodoState,
      updateTodoMessage: updateTodoMessage ?? this.updateTodoMessage,
      updateTodoState: updateTodoState ?? this.updateTodoState,
      getTodoState: getTodoState ?? this.getTodoState,
      getTodoMessage: getTodoMessage ?? this.getTodoMessage,
      stateOfTodo: stateOfTodo ?? this.stateOfTodo,
      idOfStateTodo: idOfStateTodo ?? this.idOfStateTodo
    );
  }

  @override
  List<Object?> get props => [
        addTodoState,
        addTodoMessage,
        getTodos,
        getTodosMessage,
        getTodosState,
        deleteTodoState,
        deleteTodoMessage,
        updateTodoState,
        updateTodoMessage,
        getTodoMessage,
        getTodoState
      ];
}
