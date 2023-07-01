import 'package:astronautas_app/app/modules/home/domain/entities/motoboy_entity.dart';
import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/domain/repositories/user_repository.dart';
import 'package:astronautas_app/app/modules/home/domain/usecases/get_motoboy/get_motoboy_usecase.dart';
import 'package:dartz/dartz.dart';

class GetMotoboyUsecaseImp implements GetMotoboyUsecase {
  final UserRepository _repository;

  GetMotoboyUsecaseImp(this._repository);
  @override
  Future<Either<Failure, MotoboyEntity>> call({required String email}) {
    return _repository.getMotoboy(email: email);
  }
}
