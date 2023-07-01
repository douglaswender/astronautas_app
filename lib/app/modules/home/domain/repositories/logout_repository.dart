import 'package:astronautas_app/app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class LogoutRepository {
  Future<Either<Failure, void>> call({required String email});
}
