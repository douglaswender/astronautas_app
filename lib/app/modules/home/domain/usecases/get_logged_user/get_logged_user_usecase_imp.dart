import 'package:astronautas_app/app/modules/home/domain/entities/user_entity.dart';
import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/domain/repositories/user_repository.dart';
import 'package:astronautas_app/app/modules/home/domain/usecases/get_logged_user/get_logged_user_usecase.dart';
import 'package:dartz/dartz.dart';

class GetLoggedUserUsecaseImp implements GetLoggedUserUsecase {
  final UserRepository _repository;

  GetLoggedUserUsecaseImp(this._repository);
  @override
  Future<Either<Failure, UserEntity>> call({required String email}) async {
    return _repository.getLoggedUser(email: email);
  }
}
