import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todotask/app/features/todo/domain/entites.dart';
import 'package:todotask/app/features/todo/domain/usecase/get_toto_usecase.dart';
import 'package:todotask/app/features/todo/presentation/controller/todo_bloc.dart';
import 'package:todotask/app/features/todo/presentation/controller/todo_event.dart';
import 'package:todotask/app/features/todo/presentation/controller/todo_state.dart';
import 'package:todotask/app/features/todo/presentation/pages/add_update_todo_list.dart';
import 'package:todotask/core/components/custom_text.dart';
import 'package:todotask/core/components/loading_widget.dart';
import 'package:todotask/core/enum/process_state.dart';
import 'package:todotask/core/enum/todo_state.dart';
import 'package:todotask/core/services_locator/di.dart';
import 'package:todotask/core/toast/notification_toast.dart';
import 'package:todotask/core/utils/app_color.dart';
import 'package:todotask/core/utils/app_size.dart';

class GetTodosComponents extends StatelessWidget {
  const GetTodosComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (context) => sl<TodoBloc>()..add(GetTodosEvent()),
      child: BlocBuilder<TodoBloc, TodoStates>(
        builder: (context, state) {
          if (state.getTodosState == ProcessState.loading) {
            return const LoadingWidget();
          } else if (state.getTodosState == ProcessState.loaded) {
            return RefreshIndicator(
              color: AppColor.primary,
              onRefresh: () async {
                return BlocProvider.of<TodoBloc>(context).add(GetTodosEvent());
              },
              child: ListView.separated(
                itemBuilder: (context, index) {
                  var list = state.getTodos[index];
                  Widget chooseIconIfCompleteOrPending(String stateOf){
                    if(stateOf == 'complete') {
                      return const Icon(Icons.star , color: Colors.green,);
                    } else if (stateOf == 'pending') {
                      return const Icon(Icons.pending , color: Colors.orange,);
                    }
                   return  Container();
                  }

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddUpdateTodo(
                            isAdd: false,
                            title: state.getTodos[index].title,
                            desc: state.getTodos[index].description,
                            id: state.getTodos[index].id!,
                            stateOfTodo:state.getTodos[index].stateOfTodo ,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: AppSize.s60.h,
                      padding: const EdgeInsets.only(left: AppPadding.p8),
                      decoration: BoxDecoration(
                        border: Border.all(width: AppSize.ss.w),
                        borderRadius: BorderRadius.circular(AppSize.s12),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: AppSize.s8.h,
                              ),
                              Text(
                                list.title,
                                style: const TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: AppSize.s14.h,
                              ),
                              Expanded(
                                child: Text(
                                  list.description,
                                  style: const TextStyle(color: Colors.black),
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          chooseIconIfCompleteOrPending(list.stateOfTodo),
                          const SizedBox(
                            width: 10.0,
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: AppSize.s12.h,
                ),
                itemCount: state.getTodos.length,
              ),
            );
          } else if (state.getTodosState == ProcessState.error) {
            return Center(
              child: CustomText(text: state.getTodosMessage),
            );
          }
          return Container();
        },
      ),
    );
  }

}

