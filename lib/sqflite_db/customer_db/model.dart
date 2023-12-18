const String customerTable = 'customer';

class CustomerFields {
  static final List<String> values = [
    id,
    name,
    profilePic,
    mobileNum,
    email,
    street,
    streetTwo,
    city,
    pincode,
    country,
    state,
    createdDate,
    createdTime,
    modifiedDate,
    modifiedTime,
    // flag,
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String profilePic = 'profilePic';
  static const String mobileNum = 'mobileNum';
  static const String email = 'email';
  static const String street = 'street';
  static const String streetTwo = 'streetTwo';
  static const String city = 'city';
  static const String pincode = 'pincode';
  static const String country = 'country';
  static const String state = 'state';
  static const String createdDate = 'createdDate';
  static const String createdTime = 'createdTime';
  static const String modifiedDate = 'modifiedDate';
  static const String modifiedTime = 'modifiedTime';
  // static const String flag = 'flag';
}

class Customer {
  final int? id;
  final String name;
  final String profilePic;
  final String mobileNum;
  final String email;
  final String street;
  final String streetTwo;
  final String city;
  final int pincode;
  final String country;
  final String state;
  final String createdDate;
  final String createdTime;
  final String modifiedDate;
  final String modifiedTime;
  // final bool flag;

  const Customer({
    this.id,
    required this.name,
    required this.profilePic,
    required this.mobileNum,
    required this.email,
    required this.street,
    required this.streetTwo,
    required this.city,
    required this.pincode,
    required this.country,
    required this.state,
    required this.createdDate,
    required this.createdTime,
    required this.modifiedDate,
    required this.modifiedTime,
    // required this.flag,
  });

  Customer copy({
    int? id,
    String? name,
    String? profilePic,
    String? mobileNum,
    String? email,
    String? street,
    String? streetTwo,
    String? city,
    int? pincode,
    String? country,
    String? state,
    String? createdDate,
    String? createdTime,
    String? modifiedDate,
    String? modifiedTime,
    // bool? flag,
  }) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        profilePic: profilePic ?? this.profilePic,
        mobileNum: mobileNum ?? this.mobileNum,
        email: email ?? this.email,
        street: street ?? this.street,
        streetTwo: streetTwo ?? this.streetTwo,
        city: city ?? this.city,
        pincode: pincode ?? this.pincode,
        country: country ?? this.country,
        state: state ?? this.state,
        createdDate: createdDate ?? this.createdDate,
        createdTime: createdTime ?? this.createdTime,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        modifiedTime: modifiedTime ?? this.modifiedTime,
        // flag: flag ?? this.flag,
      );

  static Customer fromJson(Map<String, Object?> json) => Customer(
        id: json[CustomerFields.id] as int?,
        name: json[CustomerFields.name] as String,
        profilePic: json[CustomerFields.profilePic] as String,
        mobileNum: json[CustomerFields.mobileNum] as String,
        email: json[CustomerFields.email] as String,
        street: json[CustomerFields.street] as String,
        streetTwo: json[CustomerFields.streetTwo] as String,
        city: json[CustomerFields.city] as String,
        pincode: json[CustomerFields.pincode] as int,
        country: json[CustomerFields.country] as String,
        state: json[CustomerFields.state] as String,
        createdDate: json[CustomerFields.createdDate] as String,
        createdTime: json[CustomerFields.createdTime] as String,
        modifiedDate: json[CustomerFields.modifiedDate] as String,
        modifiedTime: json[CustomerFields.modifiedTime] as String,
        // flag: json[CustomerFields.flag] as bool,
      );

  Map<String, Object?> toJson() => {
        CustomerFields.id: id,
        CustomerFields.name: name,
        CustomerFields.profilePic: profilePic,
        CustomerFields.mobileNum: mobileNum,
        CustomerFields.email: email,
        CustomerFields.street: street,
        CustomerFields.streetTwo: streetTwo,
        CustomerFields.city: city,
        CustomerFields.pincode: pincode,
        CustomerFields.country: country,
        CustomerFields.state: state,
        CustomerFields.createdDate: createdDate,
        CustomerFields.createdTime: createdTime,
        CustomerFields.modifiedDate: modifiedDate,
        CustomerFields.modifiedTime: modifiedTime,
        // CustomerFields.flag: flag,
      };
}
