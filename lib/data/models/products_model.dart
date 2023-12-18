class ProductsModel {
  final int error_code;
  final String message;
  final List<ProductApi> data;

  const ProductsModel({
    required this.error_code,
    required this.message,
    required this.data,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
      error_code: json['error_code'],
      message: json['message'],
      data: List<ProductApi>.from(json['data'].map((x) => ProductApi.fromJson(x))));
}

class ProductApi {
  final int id;
  final String name;
  final String image;
  final int price;
  final String created_date;
  final String created_time;
  final String modified_date;
  final String modified_time;
  final bool flag;

  const ProductApi({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.created_date,
    required this.created_time,
    required this.modified_date,
    required this.modified_time,
    required this.flag,
  });

  factory ProductApi.fromJson(Map<String, dynamic> json) => ProductApi(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        price: json['price'],
        created_date: json['created_date'],
        created_time: json['created_time'],
        modified_date: json['modified_date'],
        modified_time: json['modified_time'],
        flag: json['flag'],
      );
}
