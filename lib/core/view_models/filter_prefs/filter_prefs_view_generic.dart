class FilterPrefsViewGeneric {
  List<bool> priorities;

  FilterPrefsViewGeneric({
    this.priorities = const [false, false, false, false, false],
  });

  FilterPrefsViewGeneric update({
    required List<bool>? priorities,
  }) {
    return FilterPrefsViewGeneric(
      priorities: priorities ?? this.priorities,
    );
  }
}
