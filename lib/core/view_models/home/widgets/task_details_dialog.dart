import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_prac/constants/constants.dart';
import 'package:riverpod_prac/core/view_models/home/home_view_model.dart';

class TaskDetailsDialog extends ConsumerStatefulWidget {
  const TaskDetailsDialog({super.key});

  @override
  ConsumerState<TaskDetailsDialog> createState() => _TaskDetailsDialogState();
}

class _TaskDetailsDialogState extends ConsumerState<TaskDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    final homeController = ref.watch(homeProvider);

    return AlertDialog(
      title: const Text('Task Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Priority Level Dropdown
          DropdownButtonFormField<int>(
            value: homeController.selectedPriority,
            items: List.generate(5, (index) => index + 1)
                .map((priority) => DropdownMenuItem(
                      value: priority,
                      child: Text(AppConstant.priorityMeans[priority - 1]),
                    ))
                .toList(),
            onChanged: (value) {
              homeController.selectedPriority = value ?? 1;
            },
            decoration: const InputDecoration(labelText: 'Priority Level'),
          ),
          // Category TextField
          TextFormField(
            decoration: const InputDecoration(labelText: 'Category'),
            onChanged: (value) {
              homeController.selectedCategory = value.trim();
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop({
              'priority': homeController.selectedPriority,
              'category': homeController.selectedCategory,
            });
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
