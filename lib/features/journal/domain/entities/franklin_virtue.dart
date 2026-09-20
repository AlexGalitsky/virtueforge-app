class FranklinVirtue {
  const FranklinVirtue({
    required this.id,
    required this.stoicCategoryId,
    required this.name,
    required this.description,
    required this.defaultWeekNumber,
    this.customDescription,
  });

  final int id;
  final int stoicCategoryId;
  final String name;
  final String description;
  final String? customDescription;
  final int defaultWeekNumber;
}
