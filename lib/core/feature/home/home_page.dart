import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_prac/constants/constants.dart';
import 'package:riverpod_prac/core/models/todo_model.dart';
import 'package:riverpod_prac/core/view_models/filter_prefs/filter_prefs_view_model.dart';
import 'package:riverpod_prac/core/view_models/home/home_view_model.dart';
import 'package:uuid/uuid.dart';

import '../../view_models/home/widgets/filter_button.dart';
import '../../view_models/home/widgets/task_details_dialog.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _updatedTaskName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeProvider.notifier).fetchTodo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeController = ref.watch(homeProvider);
    final filterController = ref.watch(filterPrefsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TODO App",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        actions: [
          Center(
            child: FilterButton(
              onPressed: () {
                // Your filter action here
                print('Filter button pressed');
                Navigator.of(context).pushNamed('/FilterPrefs');
              },
            ),
          ),
          if (homeController.isLoading) const CircularProgressIndicator(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Add a new TODO',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    // if (_controller.text.isNotEmpty) {
                    //   Uuid uuid = const Uuid();
                    //   await ref.read(homeProvider.notifier).addTodo(
                    //         todo: Todo(
                    //           id: uuid.v4(),
                    //           taskName: _controller.text.trim(),
                    //           taskPriorityLevel: 1,
                    //           taskCategory: '',
                    //         ),
                    //       );
                    //
                    //   _controller.clear();
                    // }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please add a TODO first'),
                      ),
                    );
                    if (_controller.text.isNotEmpty) {
                      final result = await showDialog<Map<String, dynamic>>(
                        context: context,
                        builder: (context) => const TaskDetailsDialog(),
                      );

                      if (result != null) {
                        Uuid uuid = const Uuid();
                        await ref.read(homeProvider.notifier).addTodo(
                              todo: Todo(
                                id: uuid.v4(),
                                taskName: _controller.text.trim(),
                                taskPriorityLevel: result['priority'],
                                taskCategory: result['category'],
                              ),
                            );
                        _controller.clear();
                      }
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: homeController.todos.length,
                itemBuilder: (context, index) {
                  Todo singleTodo = homeController.todos[index];
                  final filteredTodoList = homeController.todos
                      .where((element) => element.taskPriorityLevel == homeController.todos[index].taskPriorityLevel);

                  print(filterController.priorities[singleTodo.taskPriorityLevel]);
                  print(singleTodo.taskPriorityLevel);
                  print(filterController.priorities);

                  return (!(filterController.priorities[singleTodo.taskPriorityLevel - 1]))
                      ? const SizedBox()
                      : Container(
                          padding: const EdgeInsets.all(12.0),
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 0.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0.1,
                                blurRadius: 1,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        singleTodo.taskName,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        AppConstant.priorityMeans[singleTodo.taskPriorityLevel - 1],
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        singleTodo.taskCategory,
                                        style: const TextStyle(
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.update,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {
                                          _updatedTaskName.text = singleTodo.taskName;
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Update this Todo'),
                                                content: TextField(
                                                  controller: _updatedTaskName,
                                                  decoration: const InputDecoration(
                                                    hintText: "Type here",
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                      print(_updatedTaskName.text);
                                                      singleTodo.taskName = _updatedTaskName.text;
                                                      ref.read(homeProvider.notifier).updateTodo(
                                                            todo: singleTodo,
                                                            index: index,
                                                          );
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          await ref.read(homeProvider.notifier).deleteTodo(
                                                index: index,
                                                todo: singleTodo,
                                              );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
