
class UserModel {
  final String firstname;
  final String email;
  final String phone;
  final String userId;

  UserModel({
    required this.firstname,
    required this.email,
    required this.phone,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
    'firstname': firstname,
    'email': email,
    'phone': phone,
    'userId': userId,
  };
}
