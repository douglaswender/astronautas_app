// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gold_express/app/modules/home/cubit/cliente_model.dart';
import 'package:gold_express/app/modules/home/cubit/motoboy_model.dart';

class DeliveryModel {
  final String? enderecoDestino;
  final String? status;
  final double? valorEntrega;
  final MotoboyModel? motoboy;
  final ClienteModel? cliente;
  final Timestamp timestamp;
  DeliveryModel({
    this.enderecoDestino,
    this.status,
    this.valorEntrega,
    this.motoboy,
    this.cliente,
    required this.timestamp,
  });

  DeliveryModel copyWith({
    String? enderecoDestino,
    String? status,
    double? valorEntrega,
    MotoboyModel? motoboy,
    ClienteModel? cliente,
    Timestamp? timestamp,
  }) {
    return DeliveryModel(
      enderecoDestino: enderecoDestino ?? this.enderecoDestino,
      status: status ?? this.status,
      valorEntrega: valorEntrega ?? this.valorEntrega,
      motoboy: motoboy ?? this.motoboy,
      cliente: cliente ?? this.cliente,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'enderecoDestino': enderecoDestino,
      'status': status,
      'valorEntrega': valorEntrega,
      'motoboy': motoboy?.toMap(),
      'cliente': cliente?.toMap(),
      'timestamp': timestamp,
    };
  }

  factory DeliveryModel.fromMap(Map<String, dynamic> map) {
    return DeliveryModel(
      enderecoDestino: map['enderecoDestino'] != null
          ? map['enderecoDestino'] as String
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      valorEntrega: double.tryParse(map['valorEntrega'].toString()),
      motoboy: map['motoboy'] != null
          ? MotoboyModel.fromMap(map['motoboy'] as Map<String, dynamic>)
          : null,
      cliente: map['cliente'] != null
          ? ClienteModel.fromMap(map['cliente'] as Map<String, dynamic>)
          : null,
      timestamp: map['timestamp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryModel.fromJson(String source) =>
      DeliveryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DeliveryModel(enderecoDestino: $enderecoDestino, status: $status, valorEntrega: $valorEntrega, motoboy: $motoboy, cliente: $cliente, timestamp: $timestamp)';
  }

  @override
  bool operator ==(covariant DeliveryModel other) {
    if (identical(this, other)) return true;

    return other.enderecoDestino == enderecoDestino &&
        other.status == status &&
        other.valorEntrega == valorEntrega &&
        other.motoboy == motoboy &&
        other.cliente == cliente &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return enderecoDestino.hashCode ^
        status.hashCode ^
        valorEntrega.hashCode ^
        motoboy.hashCode ^
        cliente.hashCode ^
        timestamp.hashCode;
  }
}
