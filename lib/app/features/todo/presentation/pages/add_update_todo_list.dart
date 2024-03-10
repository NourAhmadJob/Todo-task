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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  controller: titleController,
                  hint: 'Title',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter title';
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
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: AppSize.s30.h,
                ),
                if (isAdd == false)
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            stateOfTodo = 'complete';
                          },
                          child: const StaticContainer(
                            text: 'Complete',
                            color: Colors.green,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: AppSize.s8.w,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            stateOfTodo = 'pending';
                          },
                          child: const StaticContainer(
                            text: 'pending',
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                const Spacer(),
                // delete
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
                          ),
                        );
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
                      } else if (state.deleteTodoState == ProcessState.error) {
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
                            bloc.add(
                              AddTodoEvent(
                                todo: Todo(
                                  title: titleController.text,
                                  description: desController.text,
                                ),
                              ),
                            );
                          },
                          child: const StaticContainer(
                            text: 'Add Now',
                          ),
                        );
                      } else if (state.addTodoState == ProcessState.loading) {
                        return const LoadingWidget();
                      }
                      return Container();
                    },
                    listener: (context, state) {
                      if (state.addTodoState == ProcessState.loaded) {
                        NotificationManager().showSuccess(state.addTodoMessage);
                        Navigator.pop(context);
                      } else if (state.addTodoState == ProcessState.error) {
                        NotificationManager().showError(state.addTodoMessage);
                        Navigator.pop(context);
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
                                  stateOfTodo: stateOfTodo!,
                                ),
                              ),
                            );
                          },
                          child: const StaticContainer(
                            text: 'Update Now',
                          ),
                        );
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
                      } else if (state.updateTodoState == ProcessState.error) {
                        NotificationManager()
                            .showError(state.updateTodoMessage);
                        Navigator.pop(context);
                      }
                    },
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
