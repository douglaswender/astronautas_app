// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:astronautas_app/app/core/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, bool>> call({
    required LoginParams params,
  });
}

class LoginParams {
  final String email;
  final String password;
  LoginParams({
    required this.email,
    required this.password,
  });
}
