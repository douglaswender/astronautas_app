// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:astronautas_app/app/modules/home/domain/entities/user_entity.dart';

class UserDto extends UserEntity {
  UserDto({
    super.email,
    super.tipo,
    super.nome,
    super.tokens,
    super.validoAte,
    super.telefone,
  });

  UserDto copyWith({
    String? email,
    String? tipo,
    String? nome,
    List<String>? tokens,
    Timestamp? validoAte,
    String? telefone,
  }) {
    return UserDto(
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

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
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

  factory UserDto.fromJson(String source) =>
      UserDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserDto(email: $email, tipo: $tipo, nome: $nome, tokens: $tokens, validoAte: $validoAte, telefone: $telefone))';
  }

  @override
  bool operator ==(covariant UserDto other) {
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
