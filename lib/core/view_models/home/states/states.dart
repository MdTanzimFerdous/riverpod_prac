import 'package:riverpod_prac/core/models/todo_model.dart';

abstract class BaseState{}


class InitialState extends BaseState{

}

class LoadingState extends BaseState{

}

class TodoSuccessState extends BaseState{
  List<Todo> todos;
  TodoSuccessState(this.todos);
}

class SelectedPriorityState extends BaseState{
  int selectedPriority;

  SelectedPriorityState(this.selectedPriority);
}