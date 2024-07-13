import 'package:riverpod_prac/core/models/todo_model.dart';

class HomeViewGeneric {
  bool isLoading;
  List<Todo> todos;

  int selectedPriority;
  String selectedCategory;

  bool sortAsc;
  bool sortDes;

  HomeViewGeneric({
    this.isLoading = false,
    this.todos = const <Todo>[],
    this.selectedPriority = 1,
    this.selectedCategory = 'N / A',
    this.sortAsc = true,
    this.sortDes = false,
  });

  HomeViewGeneric update({
    bool? isLoading,
    List<Todo>? todos,
    int? selectedPriority,
    String? selectedCategory,
    bool? sortAsc,
    bool? sortDes,
  }) {
    return HomeViewGeneric(
      isLoading: isLoading ?? this.isLoading,
      todos: todos ?? this.todos,
      selectedPriority: selectedPriority ?? this.selectedPriority,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      sortAsc: sortAsc ?? this.sortAsc,
      sortDes: sortDes ?? this.sortDes,
    );
  }
}
