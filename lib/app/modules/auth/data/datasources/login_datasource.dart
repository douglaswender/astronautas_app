import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';

abstract class LoginDatasource {
  Future<Either<Failure, bool>> call({required LoginParams params});
}
