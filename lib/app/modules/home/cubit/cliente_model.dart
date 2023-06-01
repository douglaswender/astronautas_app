// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClienteModel {
  final String endereco;
  final String nome;
  final String email;
  final String telefone;
  ClienteModel({
    required this.endereco,
    required this.nome,
    required this.email,
    required this.telefone,
  });

  ClienteModel copyWith({
    String? endereco,
    String? nome,
    String? email,
    String? telefone,
  }) {
    return ClienteModel(
      endereco: endereco ?? this.endereco,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'endereco': endereco,
      'nome': nome,
      'email': email,
      'telefone': telefone,
    };
  }

  factory ClienteModel.fromMap(Map<String, dynamic> map) {
    return ClienteModel(
      endereco: map['endereco'] as String,
      nome: map['nome'] as String,
      email: map['email'] as String,
      telefone: map['telefone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClienteModel.fromJson(String source) =>
      ClienteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClienteModel(endereco: $endereco, nome: $nome, email: $email, telefone: $telefone)';
  }

  @override
  bool operator ==(covariant ClienteModel other) {
    if (identical(this, other)) return true;

    return other.endereco == endereco &&
        other.nome == nome &&
        other.email == email &&
        other.telefone == telefone;
  }

  @override
  int get hashCode {
    return endereco.hashCode ^
        nome.hashCode ^
        email.hashCode ^
        telefone.hashCode;
  }
}
