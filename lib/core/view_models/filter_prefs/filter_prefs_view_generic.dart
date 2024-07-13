class FilterPrefsViewGeneric {
  List<bool> priorities;

  FilterPrefsViewGeneric({
    this.priorities = const [true, true, true, true, true],
  });

  FilterPrefsViewGeneric update({
    required List<bool>? priorities,
  }) {
    return FilterPrefsViewGeneric(
      priorities: priorities ?? this.priorities,
    );
  }
}
