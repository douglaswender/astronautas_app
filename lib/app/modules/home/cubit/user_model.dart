// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String? email;
  final String? tipo;
  final String? nome;
  final List<String>? tokens;
  UserModel({
    this.email,
    this.tipo,
    this.nome,
    this.tokens,
  });

  UserModel copyWith({
    String? email,
    String? tipo,
    String? nome,
    List<String>? tokens,
  }) {
    return UserModel(
      email: email ?? this.email,
      tipo: tipo ?? this.tipo,
      nome: nome ?? this.nome,
      tokens: tokens ?? this.tokens,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'tipo': tipo,
      'nome': nome,
      'tokens': tokens,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] != null ? map['email'] as String : null,
      tipo: map['tipo'] != null ? map['tipo'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      tokens: map['tokens'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(email: $email, tipo: $tipo, nome: $nome, tokens: $tokens)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.tipo == tipo &&
        other.nome == nome &&
        listEquals(other.tokens, tokens);
  }

  @override
  int get hashCode {
    return email.hashCode ^ tipo.hashCode ^ nome.hashCode ^ tokens.hashCode;
  }
}
