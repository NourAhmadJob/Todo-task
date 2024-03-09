// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  String? id;
  final String title;
  final String description;
  final String stateOfTodo;

  Todo({
    this.id,
    this.title = '',
    this.description = '',
    this.stateOfTodo = '',
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, description, stateOfTodo];
}
