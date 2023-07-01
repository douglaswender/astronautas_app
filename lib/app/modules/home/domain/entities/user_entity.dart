import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  final String? email;
  final String? tipo;
  final String? nome;
  final List<String>? tokens;
  final Timestamp? validoAte;
  final String? telefone;

  UserEntity({
    this.email,
    this.tipo,
    this.nome,
    this.tokens,
    this.validoAte,
    this.telefone,
  });
}
