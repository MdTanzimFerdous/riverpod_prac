import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_prac/core/dto/todo_dto.dart';
import 'package:riverpod_prac/core/models/todo_model.dart';
import 'package:riverpod_prac/core/view_models/home/home_view_generic.dart';

final homeProvider = StateNotifierProvider<HomeController, HomeViewGeneric>((ref) => HomeController());

class HomeController extends StateNotifier<HomeViewGeneric> {
  HomeController() : super(HomeViewGeneric());

  TodoDto todoDto = TodoDto();

  fetchTodo() async {
    state = state.update(isLoading: true);

    try {
      List<Todo> todos = await todoDto.getTodos();

      // Sort the todos list based on task name
      // todos.sort((a, b) {
      //   if (state.sortAsc) {
      //     return a.taskName.compareTo(b.taskName);
      //   } else {
      //     return b.taskName.compareTo(a.taskName);
      //   }
      // });
      todos = sortAccordingly(todos: todos);

      state = state.update(todos: todos);
    } catch (e) {}

    state = state.update(isLoading: false);
  }

  sortAccordingly({required List<Todo> todos}) {
    todos.sort((a, b) {
      if (state.sortAsc) {
        return a.taskName.compareTo(b.taskName);
      } else {
        return b.taskName.compareTo(a.taskName);
      }
    });
    return todos;
  }

  changeSorting(String clickedBtn){
    if(clickedBtn == "Asc") {
      state = state.update(sortDes: false, sortAsc: true);
      fetchTodo();
    } else {
      state = state.update(sortAsc: false, sortDes: true);
      fetchTodo();
    }
  }

  addTodo({required Todo todo}) async {
    state = state.update(isLoading: true);

    await todoDto.putTodo(todo: todo);

    fetchTodo();
  }

  updateTodo({required Todo todo, required int index}) async {
    // state.todos[index].taskName = todo.taskName;
    // state = state.update(todos: state.todos);
    await todoDto.putTodo(todo: todo);

    fetchTodo();
  }

  deleteTodo({required int index, required Todo todo}) async {
    // state.todos.removeAt(index);
    // state = state.update(todos: state.todos);

    await todoDto.deleteTodo(todo: todo);

    fetchTodo();
  }
}
