class FilterOption {
  final String iconPath;
  final String label;
  bool isSelected;

  FilterOption({
    required this.iconPath,
    required this.label,
    this.isSelected = false,
  });
}
