//User Model
class UserModel {
  final String uid;
  final String email;
  final String name;
  final String? photoUrl;
  final bool isDoctor;

  UserModel(
      {required this.uid,
      required this.email,
      required this.name,
      required this.photoUrl,
      this.isDoctor = false});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      isDoctor: data['is_doctor'] ?? false,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "uid": uid,
        "email": email,
        "name": name,
        "photoUrl": photoUrl,
        "is_doctor": isDoctor,
      };
}
