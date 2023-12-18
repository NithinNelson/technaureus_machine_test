

const String productTable = 'product';
class ProductFields {
  static final List<String> values = [
    id,
    name,
    image,
    price,
    inCartCount,
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String image = 'image';
  static const String price = 'price';
  static const String inCartCount = 'inCartCount';
}

class Product {
  final int? id;
  final String name;
  final String image;
  final int price;
  final int inCartCount;

  const Product({
    this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.inCartCount,
  });

  Product copy({
    int? id,
    String? name,
    String? image,
    int? price,
    int? inCartCount,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        price: price ?? this.price,
        inCartCount: inCartCount ?? this.inCartCount
      );

  static Product fromJson(Map<String, Object?> json) => Product(
    id: json[ProductFields.id] as int?,
    name: json[ProductFields.name] as String,
    image: json[ProductFields.image] as String,
    price: json[ProductFields.price] as int,
    inCartCount: json[ProductFields.inCartCount] as int,
  );

  Map<String, Object?> toJson() => {
    ProductFields.id: id,
    ProductFields.name: name,
    ProductFields.image: image,
    ProductFields.price: price,
    ProductFields.inCartCount: inCartCount,
  };
}
