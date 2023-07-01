import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/data/datasource/user_datasource.dart';
import 'package:astronautas_app/app/modules/home/data/dto/user_dto.dart';
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
}
