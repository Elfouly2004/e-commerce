class ProfileModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final String token;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.token,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      image: json["image"] ?? "https://via.placeholder.com/150",
      token: json["token"],
    );
  }
}
