import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_prac/core/view_models/filter_prefs/filter_prefs_view_generic.dart';
import 'package:riverpod_prac/core/view_models/home/home_view_model.dart';

final filterPrefsProvider = StateNotifierProvider<FilterPrefsController, FilterPrefsViewGeneric>((ref) => FilterPrefsController());

class FilterPrefsController extends StateNotifier<FilterPrefsViewGeneric> {
  FilterPrefsController(): super(FilterPrefsViewGeneric());

  toggleCheck ({required int index}) {
    List<bool> priorities = state.priorities;

    priorities[index] = !priorities[index];
    state = state.update(priorities: priorities);

    print(priorities);
  }
}