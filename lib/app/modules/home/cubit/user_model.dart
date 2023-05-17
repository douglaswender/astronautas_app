// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  final String? email;
  final String? tipo;
  final String? nome;
  final List<String>? tokens;
  final Timestamp? validoAte;
  final String? telefone;
  UserModel({
    this.email,
    this.tipo,
    this.nome,
    this.tokens,
    this.validoAte,
    this.telefone,
  });

  UserModel copyWith({
    String? email,
    String? tipo,
    String? nome,
    List<String>? tokens,
    Timestamp? validoAte,
    String? telefone,
  }) {
    return UserModel(
      email: email ?? this.email,
      tipo: tipo ?? this.tipo,
      nome: nome ?? this.nome,
      tokens: tokens ?? this.tokens,
      validoAte: validoAte ?? this.validoAte,
      telefone: telefone ?? this.telefone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'tipo': tipo,
      'nome': nome,
      'tokens': tokens,
      'validoAte': validoAte,
      'telefone': telefone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] != null ? map['email'] as String : null,
      tipo: map['tipo'] != null ? map['tipo'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      tokens: map['tokens'] != null
          ? List.castFrom<dynamic, String>(map['tokens'])
          : [],
      validoAte: map['validoAte'],
      telefone: map['telefone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(email: $email, tipo: $tipo, nome: $nome, tokens: $tokens, validoAte: $validoAte, telefone: $telefone))';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.tipo == tipo &&
        other.nome == nome &&
        listEquals(other.tokens, tokens) &&
        other.validoAte == validoAte &&
        other.telefone == telefone;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        tipo.hashCode ^
        nome.hashCode ^
        tokens.hashCode ^
        validoAte.hashCode ^
        telefone.hashCode;
  }
}
