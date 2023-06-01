// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MotoboyModel {
  final String documento;
  final String nome;
  final String telefone;
  final String tipoDocumento;
  final bool? trabalhando;
  final String placa;
  MotoboyModel({
    required this.documento,
    required this.nome,
    required this.telefone,
    required this.tipoDocumento,
    this.trabalhando,
    required this.placa,
  });

  MotoboyModel copyWith(
      {String? documento,
      String? nome,
      String? telefone,
      String? tipoDocumento,
      bool? trabalhando,
      String? placa}) {
    return MotoboyModel(
      documento: documento ?? this.documento,
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
      tipoDocumento: tipoDocumento ?? this.tipoDocumento,
      trabalhando: trabalhando ?? this.trabalhando,
      placa: placa ?? this.placa,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'documento': documento,
      'nome': nome,
      'telefone': telefone,
      'tipoDocumento': tipoDocumento,
      'trabalhando': trabalhando,
      'placa': placa,
    };
  }

  Map<String, dynamic> toMapDelivery() {
    return <String, dynamic>{
      'documento': documento,
      'nome': nome,
      'telefone': telefone,
      'tipoDocumento': tipoDocumento,
      'placa': placa,
    };
  }

  factory MotoboyModel.fromMap(Map<String, dynamic> map) {
    return MotoboyModel(
      documento: map['documento'],
      nome: map['nome'],
      telefone: map['telefone'],
      tipoDocumento: map['tipoDocumento'],
      trabalhando: map['trabalhando'],
      placa: map['placa'],
    );
  }

  factory MotoboyModel.fromMapDelivery(Map<String, dynamic> map) {
    return MotoboyModel(
      documento: map['documento'],
      nome: map['nome'],
      telefone: map['telefone'],
      tipoDocumento: map['tipoDocumento'],
      placa: map['placa'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MotoboyModel.fromJson(String source) =>
      MotoboyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MotoboyModel(documento: $documento, nome: $nome, telefone: $telefone, tipoDocumento: $tipoDocumento, trabalhando: $trabalhando, placa: $placa)';
  }

  @override
  bool operator ==(covariant MotoboyModel other) {
    if (identical(this, other)) return true;

    return other.documento == documento &&
        other.nome == nome &&
        other.telefone == telefone &&
        other.tipoDocumento == tipoDocumento &&
        other.trabalhando == trabalhando &&
        other.placa == placa;
  }

  @override
  int get hashCode {
    return documento.hashCode ^
        nome.hashCode ^
        telefone.hashCode ^
        tipoDocumento.hashCode ^
        trabalhando.hashCode ^
        placa.hashCode;
  }
}
