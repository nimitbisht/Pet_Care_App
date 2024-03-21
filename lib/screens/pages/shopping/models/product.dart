class Product {
  final String name;
  final String imageurl;
  final int price;
  final int quantityCount;
  final String description;
  final String category;
  final double rating;

  Product( {
    required this.quantityCount,
    required this.category,
    required this.rating,
    required this.name,
    required this.imageurl,
    required this.price,
    required this.description,
  });
}
