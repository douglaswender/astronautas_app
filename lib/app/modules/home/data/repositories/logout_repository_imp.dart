import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/data/datasource/logout_datasource.dart';
import 'package:astronautas_app/app/modules/home/domain/repositories/logout_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutRepositoryImp implements LogoutRepository {
  final LogoutDatasource _datasource;

  LogoutRepositoryImp(this._datasource);
  @override
  Future<Either<Failure, void>> call({required String email}) async {
    return _datasource(email: email);
  }
}
