import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_prac/constants/constants.dart';
import 'package:riverpod_prac/core/view_models/filter_prefs/filter_prefs_view_model.dart';
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

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   ref.read(homeProvider.notifier).fetchTodo();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final filterPrefsController = ref.watch(filterPrefsProvider);

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
      ),
      body: Column(
        children: [
          for(var i = 0; i < AppConstant.priorityMeans.length; i++)
            CheckboxListTile(
              title: Text(AppConstant.priorityMeans[i]),
              value: filterPrefsController.priorities[i], //homeController.highPriorityFilter,
              onChanged: (newValue) {
                // ref.read(homeProvider.notifier).toggleHighPriorityFilter(newValue ?? false);
                // filterPrefsController.priorities[i] = !filterPrefsController.priorities[i];
                ref.read(filterPrefsProvider.notifier).toggleCheck(index: i);
              },
            ),
          // Add more CheckboxListTile widgets for additional filters
        ],
      ),
    );
  }
}
