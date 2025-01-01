
class Category {
  final int id;
  final String title;
  final String image; // Added image property

  Category({required this.id, required this.title, required this.image});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      image: json['image'], // Map the image field
    );
  }
}
