import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/data/dto/user_dto.dart';
import 'package:dartz/dartz.dart';

abstract class UserDatasource {
  Future<Either<Failure, UserDto>> getLoggedUser({required String email});
}
