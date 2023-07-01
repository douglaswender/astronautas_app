import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/domain/entities/motoboy_entity.dart';
import 'package:dartz/dartz.dart';

abstract class GetMotoboyUsecase {
  Future<Either<Failure, MotoboyEntity>> call({required String email});
}
