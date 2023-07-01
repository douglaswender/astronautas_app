import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/domain/entities/client_entity.dart';
import 'package:dartz/dartz.dart';

abstract class GetClientUsecase {
  Future<Either<Failure, ClientEntity>> call({required String email});
}
