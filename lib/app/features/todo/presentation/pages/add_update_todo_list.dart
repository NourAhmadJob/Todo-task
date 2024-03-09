// // Create a box collection
// final collection = await BoxCollection.open(
// 'MyFirstFluffyBox', // Name of your database
//     {'cats', 'dogs'}, // Names of your boxes
// path: './', // Path where to store your boxes (Only used in Flutter / Dart IO)
// key: HiveCipher(), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
// );
//
// // Open your boxes. Optional: Give it a type.
// final catsBox = collection.openBox<Map>('cats');
//
// // Put something in
// await catsBox.put('fluffy', {'name': 'Fluffy', 'age': 4});
// await catsBox.put('loki', {'name': 'Loki', 'age': 2});
//
// // Get values of type (immutable) Map?
// final loki = await catsBox.get('loki');
// print('Loki is ${loki?['age']} years old.');
//
// // Returns a List of values
// final cats = await catsBox.getAll(['loki', 'fluffy']);
// print(cats);
//
// // Returns a List<String> of all keys
// final allCatKeys = await catsBox.getAllKeys();
// print(allCatKeys);
//
// // Returns a Map<String, Map> with all keys and entries
// final catMap = await catsBox.getAllValues();
// print(catMap);
//
// // delete one or more entries
// await catsBox.delete('loki');
// await catsBox.deleteAll(['loki', 'fluffy']);
//
// // ...or clear the whole box at once
// await catsBox.clear();
//
// // Speed up write actions with transactions
// await collection.transaction(
// () async {
// await catsBox.put('fluffy', {'name': 'Fluffy', 'age': 4});
// await catsBox.put('loki', {'name': 'Loki', 'age': 2});
// // ...
// },
// boxNames: ['cats'], // By default all boxes become blocked.
// readOnly: false,
// );

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todotask/app/features/todo/domain/entites.dart';
import 'package:todotask/app/features/todo/domain/usecase/get_toto_usecase.dart';
import 'package:todotask/app/features/todo/presentation/components/add_update_todo_component.dart';
import 'package:todotask/app/features/todo/presentation/controller/todo_bloc.dart';
import 'package:todotask/app/features/todo/presentation/controller/todo_event.dart';
import 'package:todotask/app/features/todo/presentation/controller/todo_state.dart';
import 'package:todotask/core/components/custom_text.dart';
import 'package:todotask/core/components/custom_text_form_field.dart';
import 'package:todotask/core/components/loading_widget.dart';
import 'package:todotask/core/enum/process_state.dart';
import 'package:todotask/core/services_locator/di.dart';
import 'package:todotask/core/toast/notification_toast.dart';
import 'package:todotask/core/utils/app_color.dart';
import 'package:todotask/core/utils/app_size.dart';
import 'package:todotask/core/utils/next_back_pages.dart';

class AddUpdateTodo extends StatelessWidget {
  AddUpdateTodo(
      {Key? key,
      this.isAdd = true,
      this.title = '',
      this.desc = '',
      this.id,
      this.stateOfTodo = ''})
      : super(key: key);
  final bool isAdd;
  String title;
  String desc;
  String? id;
  String? stateOfTodo;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (isAdd == false) {
      titleController.text = title;
      desController.text = desc;
    }
    return BlocProvider<TodoBloc>(
      create: (context) => sl<TodoBloc>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          centerTitle: true,
          title: CustomText(
            text: isAdd ? 'Add new todo' : 'Update todo',
            size: AppSize.s20,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    controller: titleController,
                    hint: 'Title',
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please add your title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: AppSize.s30.h,
                  ),
                  CustomTextFormField(
                    controller: desController,
                    hint: "Description",
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please add your description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: AppSize.s30.h,
                  ),
                  if (isAdd == false)
                    BlocBuilder<TodoBloc, TodoStates>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                              child: BlocBuilder<TodoBloc, TodoStates>(
                                builder: (context, state) {
                                  return InkWell(
                                    onTap: () {
                                      print(stateOfTodo);
                                      stateOfTodo = 'complete';
                                      print(stateOfTodo);
                                    },
                                    child: const StaticContainer(
                                        text: 'Complete', color: Colors.green),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              width: AppSize.s8,
                            ),
                            Expanded(
                              child: InkWell(
                                  onTap: () {
                                    stateOfTodo = 'pending';
                                  },
                                  child: const StaticContainer(
                                    text: 'pending',
                                    color: Colors.orange,
                                  )),
                            ),
                          ],
                        );
                      },
                    ),
                  const Spacer(),
                  if (isAdd == false)
                    BlocConsumer<TodoBloc, TodoStates>(
                      builder: (context, state) {
                        if (state.deleteTodoState == ProcessState.initial) {
                          return InkWell(
                              onTap: () {
                                BlocProvider.of<TodoBloc>(context).add(
                                  DeleteTodoEvent(
                                    stringIdParameter: StringIdParameter(
                                      idTodo: id!,
                                    ),
                                  ),
                                );
                              },
                              child: const StaticContainer(
                                text: 'Delete Todo',
                                color: Colors.red,
                              ));
                        } else if (state.deleteTodoState ==
                            ProcessState.loading) {
                          return const LoadingWidget();
                        }
                        return Container();
                      },
                      listener: (context, state) {
                        if (state.deleteTodoState == ProcessState.loaded) {
                          NotificationManager()
                              .showSuccess(state.deleteTodoMessage);
                          Navigator.pop(context);
                        } else if (state.deleteTodoState ==
                            ProcessState.error) {
                          NotificationManager()
                              .showError(state.deleteTodoMessage);
                        }
                      },
                    ),
                  SizedBox(
                    height: AppSize.s20.h,
                  ),
                  if (isAdd == true)
                    BlocConsumer<TodoBloc, TodoStates>(
                      builder: (context, state) {
                        var bloc = BlocProvider.of<TodoBloc>(context);
                        if (state.addTodoState == ProcessState.initial) {
                          return InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  bloc.add(
                                    AddTodoEvent(
                                      todo: Todo(
                                        title: titleController.text,
                                        description: desController.text,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: const StaticContainer(
                                text: 'Add Now',
                              ));
                        } else if (state.addTodoState == ProcessState.loading) {
                          return const LoadingWidget();
                        }
                        return Container();
                      },
                      listener: (context, state) {
                        if (state.addTodoState == ProcessState.loaded) {
                          NotificationManager()
                              .showSuccess(state.addTodoMessage);
                          Navigator.pop(context);
                        } else if (state.addTodoState == ProcessState.error) {
                          NotificationManager().showError(state.addTodoMessage);
                        }
                      },
                    )
                  else
                    BlocConsumer<TodoBloc, TodoStates>(
                      builder: (context, state) {
                        var bloc = BlocProvider.of<TodoBloc>(context);
                        if (state.updateTodoState == ProcessState.initial) {
                          return InkWell(
                              onTap: () {
                                bloc.add(
                                  UpdateTodoEvent(
                                    todo: Todo(
                                        title: titleController.text,
                                        description: desController.text,
                                        id: id,
                                        stateOfTodo: stateOfTodo!),
                                  ),
                                );
                              },
                              child: const StaticContainer(
                                text: 'Update Now',
                              ));
                        } else if (state.updateTodoState ==
                            ProcessState.loading) {
                          return const LoadingWidget();
                        }
                        return Container();
                      },
                      listener: (context, state) {
                        if (state.updateTodoState == ProcessState.loaded) {
                          NotificationManager()
                              .showSuccess(state.updateTodoMessage);
                          Navigator.pop(context);
                        } else if (state.updateTodoState ==
                            ProcessState.error) {
                          NotificationManager()
                              .showError(state.updateTodoMessage);
                        }
                      },
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
