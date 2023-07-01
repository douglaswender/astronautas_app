import 'package:astronautas_app/app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class LogoutDatasource {
  Future<Either<Failure, void>> call({required String email});
}
