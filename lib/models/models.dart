class Uuser {
  final String name;
  final String phone;
  final String email;
  final String city;
  final String state;

  Uuser({
    required this.name,
    required this.phone,
    required this.email,
    required this.city,
    required this.state,
  });
}

class UserPremiumBool {
  final bool premium;

  UserPremiumBool({required this.premium});
}

class PremiumDataModel {
  final String houseName;
  final int length;
  final int bredth;
  final int area;
  final String type;
  final String city;
  final String state;

  PremiumDataModel({
    required this.houseName,
    required this.length,
    required this.bredth,
    required this.area,
    required this.type,
    required this.city,
    required this.state,
  });
}

class UserHousePlanModel {
  String name;
  UserHousePlanModel({required this.name});
}

class UserProfilePicModel {
  String url;
  UserProfilePicModel({required this.url});
}

class SuperviserModel {
  String name;
  String age;
  String image;
  SuperviserModel({required this.name, required this.age, required this.image});
}

class UserAmountModel {
  int total;
  UserAmountModel({required this.total});
}

class UserProgressModel {
  String percentage;
  double overAllvalue;
  int value1;
  int value2;
  int value3;
  int value4;
  int value5;
  int value6;
  int value7;
  int value8;
  UserProgressModel({
    required this.percentage,
    required this.overAllvalue,
    required this.value1,
    required this.value2,
    required this.value3,
    required this.value4,
    required this.value5,
    required this.value6,
    required this.value7,
    required this.value8,
  });
}
