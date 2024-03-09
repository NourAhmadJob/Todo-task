import 'dart:async';

import 'package:todotask/app/features/todo/domain/entites.dart';
import 'package:todotask/app/features/todo/domain/usecase/add_todo_usecase.dart';
import 'package:todotask/app/features/todo/domain/usecase/delete_todo_usecase.dart';
import 'package:todotask/app/features/todo/domain/usecase/get_todos_usecase.dart';
import 'package:todotask/app/features/todo/domain/usecase/get_toto_usecase.dart';
import 'package:todotask/app/features/todo/domain/usecase/update_todo_usecase.dart';
import 'package:todotask/app/features/todo/presentation/controller/todo_event.dart';
import 'package:todotask/app/features/todo/presentation/controller/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotask/core/constance/strings.dart';
import 'package:todotask/core/enum/process_state.dart';

class TodoBloc extends Bloc<TodoEvents, TodoStates> {
  final AddTodoUseCase addTodoUseCase;
  final GetTodosUseCase getTodosUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final GetTodoUseCase getTodoUseCase;

  TodoBloc(
      {required this.addTodoUseCase,
      required this.getTodosUseCase,
      required this.deleteTodoUseCase,
      required this.updateTodoUseCase,
      required this.getTodoUseCase})
      : super(const TodoStates()) {
    on<AddTodoEvent>(_addTodoFunction);
    on<GetTodosEvent>(_getTodosFunction);
    on<DeleteTodoEvent>(_deleteTodoFunction);
    on<UpdateTodoEvent>(_updateTodoFunction);
    on<GetTodoEvent>(_getTodoFunction);
  }

  FutureOr<void> _addTodoFunction(
      AddTodoEvent event, Emitter<TodoStates> emit) async {
    emit(state.copyWith(addTodoState: ProcessState.loading));
    final result = await addTodoUseCase.call(
      Todo(
        description: event.todo.description,
        title: event.todo.title,
        stateOfTodo: 'initial',
      ),
    );

    result.fold(
      (left) => emit(
        state.copyWith(
          addTodoState: ProcessState.error,
          addTodoMessage: left.message,
        ),
      ),
      (right) => emit(
        state.copyWith(
          addTodoState: ProcessState.loaded,
          addTodoMessage: StringsManager.ADDED_TODO_SUCCESSFULLY,
        ),
      ),
    );
  }

  FutureOr<void> _getTodosFunction(
      GetTodosEvent event, Emitter<TodoStates> emit) async {
    emit(
      state.copyWith(
        getTodosState: ProcessState.loading,
      ),
    );
    final result = await getTodosUseCase.call(const NoParameter());

    result.fold(
      (left) => emit(
        state.copyWith(
          getTodosState: ProcessState.error,
          getTodosMessage: left.message,
        ),
      ),
      (right) => emit(
        state.copyWith(
          getTodosState: ProcessState.loaded,
          getTodosMessage: StringsManager.ADDED_TODO_SUCCESSFULLY,
          getTodos: right,
        ),
      ),
    );
  }

  FutureOr<void> _deleteTodoFunction(
      DeleteTodoEvent event, Emitter<TodoStates> emit) async {
    emit(state.copyWith(deleteTodoState: ProcessState.loading));
    final result = await deleteTodoUseCase
        .call(StringIdParameter(idTodo: event.stringIdParameter.idTodo));

    result.fold(
      (left) => emit(
        state.copyWith(
            deleteTodoState: ProcessState.error,
            deleteTodoMessage: left.message),
      ),
      (right) => emit(
        state.copyWith(
          deleteTodoState: ProcessState.loaded,
          deleteTodoMessage: StringsManager.DELETE_TODO_SUCCESSFULLY,
        ),
      ),
    );
  }

  FutureOr<void> _updateTodoFunction(
      UpdateTodoEvent event, Emitter<TodoStates> emit) async {
    emit(state.copyWith(updateTodoState: ProcessState.loading));
    final result = await updateTodoUseCase.call(
      Todo(
        title: event.todo.title,
        description: event.todo.description,
        id: event.todo.id,
        stateOfTodo: event.todo.stateOfTodo
      ),
    );

    result.fold(
      (left) => emit(
        state.copyWith(
          updateTodoMessage: left.message,
          updateTodoState: ProcessState.error,
        ),
      ),
      (right) {
        emit(
          state.copyWith(
            updateTodoMessage: StringsManager.UPDATE_TODO_SUCCESSFULLY,
            updateTodoState: ProcessState.loaded,
          ),
        );
      }
    );
  }

  _getTodoFunction(GetTodoEvent event, Emitter<TodoStates> emit) async {
    emit(state.copyWith(getTodoState: ProcessState.loading));
    final result = await getTodoUseCase
        .call(StringIdParameter(idTodo: event.stringIdParameter.idTodo));

    result.fold(
        (left) => emit(
              state.copyWith(
                getTodoMessage: left.message,
                getTodoState: ProcessState.error,
              ),
            ), (right) {
      emit(
        state.copyWith(
          getTodoState: ProcessState.loaded,
        ),
      );
    });
  }

}
