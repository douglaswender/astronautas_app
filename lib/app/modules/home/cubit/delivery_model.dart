// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gold_express/app/modules/home/cubit/user_model.dart';

class DeliveryModel {
  final String? enderecoDestino;
  final String? status;
  final double? valorEntrega;
  final UserModel? motoboy;
  final UserModel? cliente;
  DeliveryModel({
    this.enderecoDestino,
    this.status,
    this.valorEntrega,
    this.motoboy,
    this.cliente,
  });

  DeliveryModel copyWith({
    String? enderecoDestino,
    String? status,
    double? valorEntrega,
    UserModel? motoboy,
    UserModel? cliente,
  }) {
    return DeliveryModel(
      enderecoDestino: enderecoDestino ?? this.enderecoDestino,
      status: status ?? this.status,
      valorEntrega: valorEntrega ?? this.valorEntrega,
      motoboy: motoboy ?? this.motoboy,
      cliente: cliente ?? this.cliente,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'enderecoDestino': enderecoDestino,
      'status': status,
      'valorEntrega': valorEntrega,
      'motoboy': motoboy?.toMap(),
      'cliente': cliente?.toMap(),
    };
  }

  factory DeliveryModel.fromMap(Map<String, dynamic> map) {
    return DeliveryModel(
      enderecoDestino: map['endereco_destino'] != null
          ? map['endereco_destino'] as String
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      valorEntrega: map['valor_entrega'] != null
          ? double.tryParse(map['valor_entrega'].toString())
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryModel.fromJson(String source) =>
      DeliveryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DeliveryModel(enderecoDestino: $enderecoDestino, status: $status, valorEntrega: $valorEntrega, motoboy: $motoboy, cliente: $cliente)';
  }

  @override
  bool operator ==(covariant DeliveryModel other) {
    if (identical(this, other)) return true;

    return other.enderecoDestino == enderecoDestino &&
        other.status == status &&
        other.valorEntrega == valorEntrega &&
        other.motoboy == motoboy &&
        other.cliente == cliente;
  }

  @override
  int get hashCode {
    return enderecoDestino.hashCode ^
        status.hashCode ^
        valorEntrega.hashCode ^
        motoboy.hashCode ^
        cliente.hashCode;
  }
}
