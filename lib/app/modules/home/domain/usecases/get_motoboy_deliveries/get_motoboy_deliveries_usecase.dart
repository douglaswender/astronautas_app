import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/domain/entities/motoboy_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class GetMotoboyDeliveriesUsecase {
  Future<Either<Failure, Stream<QuerySnapshot<Object?>>?>> call(
      {required MotoboyEntity motoboy});
}
