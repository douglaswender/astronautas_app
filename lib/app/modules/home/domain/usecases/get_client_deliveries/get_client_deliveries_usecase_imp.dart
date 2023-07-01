import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/domain/entities/client_entity.dart';
import 'package:astronautas_app/app/modules/home/domain/repositories/user_repository.dart';
import 'package:astronautas_app/app/modules/home/domain/usecases/get_client_deliveries/get_client_deliveries_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetClientDeliveriesUsecaseImp implements GetClientDeliveriesUsecase {
  final UserRepository _repository;

  GetClientDeliveriesUsecaseImp(this._repository);
  @override
  Future<Either<Failure, Stream<QuerySnapshot<Object?>>?>> call(
      {required ClientEntity client}) {
    return _repository.getClientDeliveries(client: client);
  }
}
