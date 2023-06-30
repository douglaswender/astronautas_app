import 'package:astronautas_app/app/modules/auth/data/datasources/login_datasource.dart';
import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoryImp implements LoginRepository {
  final LoginDatasource _datasource;

  LoginRepositoryImp(this._datasource);
  @override
  Future<Either<Failure, bool>> call({required LoginParams params}) {
    return _datasource(params: params);
  }
}
