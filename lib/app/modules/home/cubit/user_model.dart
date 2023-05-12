// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

class UserModel {
  final String? email;
  final String? tipo;
  final List<String>? tokens;
  UserModel({
    this.email,
    this.tipo,
    this.tokens,
  });

  UserModel copyWith({
    String? email,
    String? tipo,
    List<String>? tokens,
  }) {
    return UserModel(
      email: email ?? this.email,
      tipo: tipo ?? this.tipo,
      tokens: tokens ?? this.tokens,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'tipo': tipo,
      'tokens': tokens,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] != null ? map['email'] as String : null,
      tipo: map['tipo'] != null ? map['tipo'] as String : null,
      tokens: map['tokens'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(email: $email, tipo: $tipo, tokens: $tokens)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.email == email &&
        other.tipo == tipo &&
        listEquals(other.tokens, tokens);
  }

  @override
  int get hashCode => email.hashCode ^ tipo.hashCode ^ tokens.hashCode;
}
