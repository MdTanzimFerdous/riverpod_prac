import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_prac/constants/constants.dart';
import 'package:riverpod_prac/core/view_models/home/home_view_model.dart';
import 'package:uuid/uuid.dart';

import '../../models/todo_model.dart';

class FilterPrefs extends ConsumerStatefulWidget {
  const FilterPrefs({super.key});

  @override
  ConsumerState<FilterPrefs> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<FilterPrefs> {
  final TextEditingController _controller = TextEditingController();

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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Set Filter Preferences",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        actions: [if (homeController.isLoading) const CircularProgressIndicator()],
      ),
      body: Column(
        children: [
          for(var i = 0; i < AppConstant.priorityMeans.length; i++)
            CheckboxListTile(
              title: Text(AppConstant.priorityMeans[i]),
              value: false, //homeController.highPriorityFilter,
              onChanged: (newValue) {
                // ref.read(homeProvider.notifier).toggleHighPriorityFilter(newValue ?? false);
              },
            ),
          // Add more CheckboxListTile widgets for additional filters
        ],
      ),
    );
  }
}
