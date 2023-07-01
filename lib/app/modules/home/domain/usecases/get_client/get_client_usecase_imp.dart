import 'package:astronautas_app/app/modules/home/domain/entities/client_entity.dart';
import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/domain/repositories/user_repository.dart';
import 'package:astronautas_app/app/modules/home/domain/usecases/get_client/get_client_usecase.dart';
import 'package:dartz/dartz.dart';

class GetClientUsecaseImp implements GetClientUsecase {
  final UserRepository _repository;

  GetClientUsecaseImp(this._repository);
  @override
  Future<Either<Failure, ClientEntity>> call({required String email}) async {
    return _repository.getClient(email: email);
  }
}
