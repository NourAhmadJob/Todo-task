import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:todotask/app/features/todo/data/datasource.dart';
import 'package:todotask/app/features/todo/data/repository_imp.dart';
import 'package:todotask/app/features/todo/domain/entites.dart';
import 'package:todotask/app/features/todo/domain/repository.dart';
import 'package:todotask/app/features/todo/domain/usecase/add_todo_usecase.dart';
import 'package:todotask/app/features/todo/domain/usecase/delete_todo_usecase.dart';
import 'package:todotask/app/features/todo/domain/usecase/get_todos_usecase.dart';
import 'package:todotask/app/features/todo/domain/usecase/get_toto_usecase.dart';
import 'package:todotask/app/features/todo/domain/usecase/update_todo_usecase.dart';
import 'package:todotask/app/features/todo/presentation/controller/todo_bloc.dart';

GetIt sl = GetIt.instance;

class ServicesLocator  {
  void init() async {
    // bloc
    sl.registerFactory<TodoBloc>(
          () => TodoBloc(
            getTodosUseCase: sl(),
            deleteTodoUseCase: sl(),
            getTodoUseCase: sl(),
            updateTodoUseCase: sl(),
            addTodoUseCase: sl(),
          ),
    );
    // repository
    sl.registerLazySingleton<BaseTodoRepository>(() =>
        TodoRepositoryImp(baseDataSource: sl()));

    // useCase
    sl.registerLazySingleton(() => AddTodoUseCase(baseTodoRepository: sl()));
    sl.registerLazySingleton(() => DeleteTodoUseCase(baseTodoRepository: sl()));
    sl.registerLazySingleton(() => GetTodosUseCase(baseTodoRepository: sl()));
    sl.registerLazySingleton(() => UpdateTodoUseCase(baseTodoRepository: sl()));
    sl.registerLazySingleton(() => GetTodoUseCase(baseTodoRepository: sl()));
  }
}
