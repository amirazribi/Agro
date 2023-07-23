//User Model
import 'enum/user_type.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String? photoUrl;

  UserType type ;

  UserModel(
      {required this.uid,
      required this.email,
      required this.name,
      required this.photoUrl,
        required this.type,
     });

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      type: UserType.fromJson(data["type"]),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "uid": uid,
        "email": email,
        "name": name,
        "photoUrl": photoUrl,
        "type": type.toJson(),
      };
}
