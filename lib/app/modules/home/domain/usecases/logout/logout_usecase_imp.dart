import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/domain/repositories/logout_repository.dart';
import 'package:astronautas_app/app/modules/home/domain/usecases/logout/logout_usecase.dart';
import 'package:dartz/dartz.dart';

class LogoutUsecaseImp implements LogoutUsecase {
  final LogoutRepository _repository;

  LogoutUsecaseImp(this._repository);
  @override
  Future<Either<Failure, void>> call({required String email}) async {
    return _repository(email: email);
  }
}
