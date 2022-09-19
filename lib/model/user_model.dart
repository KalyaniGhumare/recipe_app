class UserModel {
  String? uId, name, email;

  UserModel({
    this.uId,
    this.name,
    this.email,
  });

  UserModel.fromJson(json) {
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uId'] = uId;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}
