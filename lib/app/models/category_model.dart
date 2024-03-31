class Category {
  final String imageUrl;
  final String title;
  final String? parameter;
  final bool isMore;

  Category({
    required this.imageUrl,
    required this.title,
    required this.isMore,
    this.parameter,
  });
}
