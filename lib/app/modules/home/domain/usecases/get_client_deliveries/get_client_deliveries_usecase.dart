import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/domain/entities/client_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class GetClientDeliveriesUsecase {
  Future<Either<Failure, Stream<QuerySnapshot<Object?>>?>> call(
      {required ClientEntity client});
}
