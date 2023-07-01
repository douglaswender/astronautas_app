// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:astronautas_app/app/modules/home/domain/entities/motoboy_entity.dart';

class MotoboyDto extends MotoboyEntity {
  MotoboyDto({
    required super.documento,
    required super.nome,
    required super.telefone,
    required super.tipoDocumento,
    super.trabalhando,
    required super.placa,
  });

  MotoboyDto copyWith({
    String? documento,
    String? nome,
    String? telefone,
    String? tipoDocumento,
    bool? trabalhando,
    String? placa,
  }) {
    return MotoboyDto(
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

  factory MotoboyDto.fromMap(Map<String, dynamic> map) {
    return MotoboyDto(
      documento: map['documento'] as String,
      nome: map['nome'] as String,
      telefone: map['telefone'] as String,
      tipoDocumento: map['tipoDocumento'] as String,
      trabalhando:
          map['trabalhando'] != null ? map['trabalhando'] as bool : null,
      placa: map['placa'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MotoboyDto.fromJson(String source) =>
      MotoboyDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MotoboyDto(documento: $documento, nome: $nome, telefone: $telefone, tipoDocumento: $tipoDocumento, trabalhando: $trabalhando, placa: $placa)';
  }

  @override
  bool operator ==(covariant MotoboyDto other) {
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
