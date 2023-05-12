// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MotoboyModel {
  final String documento;
  final String nome;
  final String telefone;
  final String tipoDocumento;
  final bool trabalhando;
  MotoboyModel({
    required this.documento,
    required this.nome,
    required this.telefone,
    required this.tipoDocumento,
    required this.trabalhando,
  });

  MotoboyModel copyWith({
    String? documento,
    String? nome,
    String? telefone,
    String? tipoDocumento,
    bool? trabalhando,
  }) {
    return MotoboyModel(
      documento: documento ?? this.documento,
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
      tipoDocumento: tipoDocumento ?? this.tipoDocumento,
      trabalhando: trabalhando ?? this.trabalhando,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'documento': documento,
      'nome': nome,
      'telefone': telefone,
      'tipoDocumento': tipoDocumento,
      'trabalhando': trabalhando,
    };
  }

  factory MotoboyModel.fromMap(Map<String, dynamic> map) {
    return MotoboyModel(
      documento: map['documento'] as String,
      nome: map['nome'] as String,
      telefone: map['telefone'] as String,
      tipoDocumento: map['tipoDocumento'] as String,
      trabalhando: map['trabalhando'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MotoboyModel.fromJson(String source) =>
      MotoboyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MotoboyModel(documento: $documento, nome: $nome, telefone: $telefone, tipoDocumento: $tipoDocumento, trabalhando: $trabalhando)';
  }

  @override
  bool operator ==(covariant MotoboyModel other) {
    if (identical(this, other)) return true;

    return other.documento == documento &&
        other.nome == nome &&
        other.telefone == telefone &&
        other.tipoDocumento == tipoDocumento &&
        other.trabalhando == trabalhando;
  }

  @override
  int get hashCode {
    return documento.hashCode ^
        nome.hashCode ^
        telefone.hashCode ^
        tipoDocumento.hashCode ^
        trabalhando.hashCode;
  }
}
