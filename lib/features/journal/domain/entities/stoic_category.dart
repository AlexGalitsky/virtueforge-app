class StoicCategory {
  const StoicCategory({
    required this.id,
    required this.name,
    required this.description,
    this.iconPath,
  });

  final int id;
  final String name;
  final String description;
  final String? iconPath;
}
