import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/domain/entities/client_entity.dart';
import 'package:astronautas_app/app/modules/home/domain/entities/motoboy_entity.dart';
import 'package:astronautas_app/app/modules/home/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getLoggedUser({required String email});
  Future<Either<Failure, ClientEntity>> getClient({required String email});
  Future<Either<Failure, Stream<QuerySnapshot<Object?>>?>> getClientDeliveries(
      {required ClientEntity client});
  Future<Either<Failure, MotoboyEntity>> getMotoboy({required String email});
  Future<Either<Failure, Stream<QuerySnapshot<Object?>>?>> getMotoboyDeliveries(
      {required MotoboyEntity motoboy});
}
