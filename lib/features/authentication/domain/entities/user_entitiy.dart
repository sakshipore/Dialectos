import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String profileUrl;
  final String uid;

  UserEntity({
    required this.name,
    required this.email,
    required this.profileUrl,
    required this.uid,
  });

  @override
  List<Object?> get props => [name, email, profileUrl, uid];
}
