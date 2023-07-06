import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String email;
  final String nickname;

  const UserModel({
    required this.email,
    required this.id,
    required this.nickname,
  });

  @override
  List<Object> get props => [
        nickname,
        email,
        id,
      ];

  factory UserModel.fromJson(Map<String, dynamic>  map) {
    return UserModel(
      email: map['email'] as String,
      id: map['id'] as int,
      nickname: map['nickname'] as String,
    );
  }
}
