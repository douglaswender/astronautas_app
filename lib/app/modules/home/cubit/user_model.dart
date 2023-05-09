// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? email;
  final String? name;
  final String? tipo;
  UserModel({
    this.email,
    this.name,
    this.tipo,
  });

  UserModel copyWith({
    String? email,
    String? name,
    String? tipo,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      tipo: tipo ?? this.tipo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'tipo': tipo,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] != null ? map['email'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      tipo: map['tipo'] != null ? map['tipo'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(email: $email, name: $name, tipo: $tipo)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email && other.name == name && other.tipo == tipo;
  }

  @override
  int get hashCode => email.hashCode ^ name.hashCode ^ tipo.hashCode;
}
