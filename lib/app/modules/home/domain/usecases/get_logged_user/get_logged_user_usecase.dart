import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class GetLoggedUserUsecase {
  Future<Either<Failure, UserEntity>> call({required String email});
}
