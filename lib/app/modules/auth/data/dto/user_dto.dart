// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:astronautas_app/app/modules/auth/domain/entities/user_entity.dart';

class UserDto extends UserEntity {
  UserDto({
    required super.email,
    required super.password,
  });

  UserDto copyWith({
    String? email,
    String? password,
  }) {
    return UserDto(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDto.fromJson(String source) =>
      UserDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserDto(email: $email, password: $password)';

  @override
  bool operator ==(covariant UserDto other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
