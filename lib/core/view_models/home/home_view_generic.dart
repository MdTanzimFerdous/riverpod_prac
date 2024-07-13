import 'package:riverpod_prac/core/models/todo_model.dart';

class HomeViewGeneric {
  bool isLoading;
  List<Todo> todos;

  int selectedPriority = 1;
  String selectedCategory = '';

  HomeViewGeneric({
    this.isLoading = false,
    this.todos = const <Todo>[],
  });

  HomeViewGeneric update({
    bool? isLoading,
    List<Todo>? todos,
  }) {
    return HomeViewGeneric(
      isLoading: isLoading ?? this.isLoading,
      todos: todos ?? this.todos,
    );
  }
}
