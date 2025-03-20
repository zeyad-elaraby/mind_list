class UserModel {
  String id;
  String name;
  String email;
  int age;
  String phone;

  UserModel(
      {this.id = "",
        required this.name,
        required this.email,
        required this.age,
        required this.phone });
  UserModel.fromJson(Map<String, dynamic> json)
      : this(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    age: json["age"],
    phone: json["phone"],
  );
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "age": age,
      "phone": phone,
    };
  }
}
