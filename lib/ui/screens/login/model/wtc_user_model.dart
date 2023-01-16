class WtcUserModel {
  WtcUserModel({
    required this.success,
  });

  Success success;

  factory WtcUserModel.fromJson(Map<String, dynamic> json) =>
      WtcUserModel(success: Success.fromJson(json["success"]));

  Map<String, dynamic> toJson() => {"success": success.toJson()};
}

class Success {
  Success({
    this.message = "",
    this.token = "",
    this.id = -1,
    this.firstname = "",
    this.lastname = "",
    this.username = "",
    this.email = "",
    this.profileImg = "",
  });

  String message;
  String token;
  int id;
  String firstname;
  String lastname;
  String username;
  String email;
  String profileImg;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
      message: json["message"] ?? "",
      token: json["token"] ?? "",
      id: json["id"] ?? -1,
      firstname: json["firstname"] ?? "",
      lastname: json["lastname"] ?? "",
      username: json["username"] ?? "",
      email: json["email"] ?? "",
      profileImg: json["profile_img"] ?? "");
  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "profile_img": profileImg
      };
}
