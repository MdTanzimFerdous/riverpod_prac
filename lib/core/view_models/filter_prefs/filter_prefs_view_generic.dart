class FilterPrefsViewGeneric {
  List<int> priorities;

  FilterPrefsViewGeneric({
    this.priorities = const [],
  });

  FilterPrefsViewGeneric update({
    required List<int>? priorities,
  }) {
    return FilterPrefsViewGeneric(
      priorities: priorities ?? this.priorities,
    );
  }
}
