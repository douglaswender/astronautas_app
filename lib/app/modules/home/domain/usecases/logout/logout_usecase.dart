import 'package:astronautas_app/app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class LogoutUsecase {
  Future<Either<Failure, void>> call({required String email});
}
