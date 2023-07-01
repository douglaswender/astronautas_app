// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:astronautas_app/app/modules/home/domain/entities/client_entity.dart';

class ClientDto extends ClientEntity {
  ClientDto({
    required super.email,
    required super.endereco,
    required super.nome,
    required super.telefone,
  });

  ClientDto copyWith({
    String? email,
    String? endereco,
    String? nome,
    String? telefone,
  }) {
    return ClientDto(
      email: email ?? this.email,
      endereco: endereco ?? this.endereco,
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'endereco': endereco,
      'nome': nome,
      'telefone': telefone,
    };
  }

  factory ClientDto.fromMap(Map<String, dynamic> map) {
    return ClientDto(
      email: map['email'] as String,
      endereco: map['endereco'] as String,
      nome: map['nome'] as String,
      telefone: map['telefone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientDto.fromJson(String source) =>
      ClientDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClientDto(email: $email, endereco: $endereco, nome: $nome, telefone: $telefone)';
  }

  @override
  bool operator ==(covariant ClientDto other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.endereco == endereco &&
        other.nome == nome &&
        other.telefone == telefone;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        endereco.hashCode ^
        nome.hashCode ^
        telefone.hashCode;
  }
}
