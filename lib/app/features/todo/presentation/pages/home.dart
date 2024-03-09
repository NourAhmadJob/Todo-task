import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotask/app/features/todo/domain/entites.dart';
import 'package:todotask/app/features/todo/presentation/components/todos_list_components.dart';
import 'package:todotask/app/features/todo/presentation/controller/todo_bloc.dart';
import 'package:todotask/app/features/todo/presentation/controller/todo_event.dart';
import 'package:todotask/app/features/todo/presentation/controller/todo_state.dart';
import 'package:todotask/app/features/todo/presentation/pages/add_update_todo_list.dart';
import 'package:todotask/core/components/custom_floating_action_button.dart';
import 'package:todotask/core/components/custom_text.dart';
import 'package:todotask/core/services_locator/di.dart';
import 'package:todotask/core/utils/app_color.dart';
import 'package:todotask/core/utils/app_size.dart';
import 'package:todotask/core/utils/next_back_pages.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primary,
        title: CustomText(
          text: 'All Todo List',
          size: AppSize.s20,
          fontWeight: FontWeight.w800,
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
          icon: Icons.add,
          onPressed: () {
            NextBackPages().nextPage(
              context,
              AddUpdateTodo(
                isAdd: true,
              ),
            );
          }),
      body: const Padding(
        padding: EdgeInsets.all(AppPadding.p25),
        child: GetTodosComponents(),
      ),
    );
  }
}
