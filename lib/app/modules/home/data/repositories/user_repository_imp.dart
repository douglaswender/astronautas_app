import 'package:astronautas_app/app/modules/home/data/datasource/user_datasource.dart';
import 'package:astronautas_app/app/modules/home/domain/entities/client_entity.dart';
import 'package:astronautas_app/app/modules/home/domain/entities/motoboy_entity.dart';
import 'package:astronautas_app/app/modules/home/domain/entities/user_entity.dart';
import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/domain/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImp implements UserRepository {
  final UserDatasource _datasource;

  UserRepositoryImp(this._datasource);
  @override
  Future<Either<Failure, UserEntity>> getLoggedUser({required String email}) {
    return _datasource.getLoggedUser(email: email);
  }

  @override
  Future<Either<Failure, ClientEntity>> getClient({required String email}) {
    return _datasource.getClient(email: email);
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Object?>>?>> getClientDeliveries(
      {required ClientEntity client}) {
    return _datasource.getClientDeliveries(client: client);
  }

  @override
  Future<Either<Failure, MotoboyEntity>> getMotoboy({required String email}) {
    return _datasource.getMotoboy(email: email);
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Object?>>?>> getMotoboyDeliveries(
      {required MotoboyEntity motoboy}) {
    return _datasource.getMotoboyDeliveries(motoboy: motoboy);
  }
}
