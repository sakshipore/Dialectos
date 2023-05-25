import 'package:dialectos/features/authentication/domain/entities/user_entitiy.dart';

class UserModel extends UserEntity {
  final bool emailVerified;
  final String phoneNumber;
  final String refreshToken;

  UserModel({
    required super.name,
    required super.email,
    required super.profileUrl,
    required super.uid,
    required this.emailVerified,
    required this.phoneNumber,
    required this.refreshToken,
  });

  // TODO: Create JSON methods
}
