class CustomersModel {
  final int error_code;
  final String message;
  final List<CustomerApi> data;

  const CustomersModel({
    required this.error_code,
    required this.message,
    required this.data,
  });

  factory CustomersModel.fromJson(Map<String, dynamic> json) => CustomersModel(
      error_code: json['error_code'],
      message: json['message'],
      data: List<CustomerApi>.from(json['data'].map((x) => CustomerApi.fromJson(x))));
}

class CustomerApi {
  final int id;
  final String name;
  final String profile_pic;
  final String mobile_number;
  final String email;
  final String street;
  final String street_two;
  final String city;
  final int pincode;
  final String country;
  final String state;
  final String created_date;
  final String created_time;
  final String modified_date;
  final String modified_time;
  final bool flag;

  const CustomerApi({
    required this.id,
    required this.name,
    required this.profile_pic,
    required this.mobile_number,
    required this.email,
    required this.street,
    required this.street_two,
    required this.city,
    required this.pincode,
    required this.country,
    required this.state,
    required this.created_date,
    required this.created_time,
    required this.modified_date,
    required this.modified_time,
    required this.flag,
  });

  factory CustomerApi.fromJson(Map<String, dynamic> json) => CustomerApi(
    id: json['id'],
    name: json['name'] ?? "",
    profile_pic: json['profile_pic'] ?? "",
    mobile_number: json['mobile_number'] ?? "",
    email: json['email'] ?? "",
    street: json['street'] ?? "",
    street_two: json['street_two'] ?? "",
    city: json['city'] ?? "",
    pincode: json['pincode'],
    country: json['country'] ?? "",
    state: json['state'] ?? "",
    created_date: json['created_date'] ?? "",
    created_time: json['created_time'] ?? "",
    modified_date: json['modified_date'] ?? "",
    modified_time: json['modified_time'] ?? "",
    flag: json['flag'],
  );
}
