import 'dart:convert';

class CruiseUser {
  CruiseUser({
    required this.phone,
    required this.registerTime,
  });

  String? phone;
  String? registerTime;

  factory CruiseUser.fromJson(String str) => CruiseUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());


  factory CruiseUser.fromMap(Map<String, dynamic> json) => CruiseUser(
    phone: json["phone"] == null ? null : json["phone"],
    registerTime: json["registerTime"] == null ? null : json["registerTime"],
  );

  Map<String, dynamic> toMap() => {
    "phone": phone == null ? null : phone,
    "registerTime": registerTime == null ? null : registerTime,
  };
}