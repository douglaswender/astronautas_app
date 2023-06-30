import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:astronautas_app/app/modules/auth/domain/usecases/login/login_usecase.dart';
import 'package:dartz/dartz.dart';

class LoginUsecaseImp implements LoginUsecase {
  final LoginRepository _repository;

  LoginUsecaseImp(this._repository);

  @override
  Future<Either<Failure, bool>> call({required LoginParams params}) async {
    return _repository(params: params);
  }
}
