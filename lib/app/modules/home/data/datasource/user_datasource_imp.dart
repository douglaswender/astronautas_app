import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/data/datasource/user_datasource.dart';
import 'package:astronautas_app/app/modules/home/data/dto/client_dto.dart';
import 'package:astronautas_app/app/modules/home/data/dto/motoboy_dto.dart';
import 'package:astronautas_app/app/modules/home/data/dto/user_dto.dart';
import 'package:astronautas_app/app/modules/home/domain/entities/client_entity.dart';
import 'package:astronautas_app/app/modules/home/domain/entities/motoboy_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class UserDatasourceImp implements UserDatasource {
  final FirebaseFirestore _db;

  UserDatasourceImp(this._db);
  @override
  Future<Either<Failure, UserDto>> getLoggedUser(
      {required String email}) async {
    try {
      final userData = await _db
          .collection('usuarios')
          .doc(email)
          .get()
          .then((value) => value.data());
      return Right(UserDto.fromMap(userData!));
    } catch (e) {
      return Left(Failure(error: e));
    }
  }

  @override
  Future<Either<Failure, ClientDto>> getClient({required String email}) async {
    try {
      final cliente = await _db
          .collection('clientes')
          .doc(email)
          .get()
          .then((value) => value.data());
      return Right(ClientDto.fromMap(cliente!));
    } catch (e) {
      return Left(Failure(error: e));
    }
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Object?>>?>> getClientDeliveries(
      {required ClientEntity client}) async {
    try {
      final stream = _db
          .collection('entregas')
          .where('cliente', isEqualTo: (client as ClientDto).toMap())
          .orderBy('timestamp', descending: true)
          .limit(10)
          .snapshots();
      return Right(stream);
    } catch (e) {
      return Left(Failure(error: e));
    }
  }

  @override
  Future<Either<Failure, MotoboyEntity>> getMotoboy(
      {required String email}) async {
    try {
      return Right(await _db
          .collection('motoboys')
          .doc(email)
          .get()
          .then((value) => MotoboyDto.fromMap(value.data()!)));
    } catch (e) {
      return Left(Failure(error: e));
    }
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Object?>>?>> getMotoboyDeliveries(
      {required MotoboyEntity motoboy}) async {
    try {
      return Right(_db
          .collection('entregas')
          .where('motoboy', isEqualTo: (motoboy as MotoboyDto).toMapDelivery())
          .orderBy('timestamp', descending: true)
          .limit(10)
          .snapshots());
    } catch (e) {
      return Left(Failure(error: e));
    }
  }
}
