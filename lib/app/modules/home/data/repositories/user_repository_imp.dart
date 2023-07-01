import 'package:astronautas_app/app/modules/home/data/datasource/user_datasource.dart';
import 'package:astronautas_app/app/modules/home/domain/entities/user_entity.dart';
import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImp implements UserRepository {
  final UserDatasource _datasource;

  UserRepositoryImp(this._datasource);
  @override
  Future<Either<Failure, UserEntity>> getLoggedUser({required String email}) {
    return _datasource.getLoggedUser(email: email);
  }
}
