import 'package:astronautas_app/app/modules/home/domain/entities/motoboy_entity.dart';
import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/domain/repositories/user_repository.dart';
import 'package:astronautas_app/app/modules/home/domain/usecases/get_motoboy_deliveries/get_motoboy_deliveries_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetMotoboyDeliveriesUsecaseImp implements GetMotoboyDeliveriesUsecase {
  final UserRepository _repository;

  GetMotoboyDeliveriesUsecaseImp(this._repository);
  @override
  Future<Either<Failure, Stream<QuerySnapshot<Object?>>?>> call(
      {required MotoboyEntity motoboy}) {
    return _repository.getMotoboyDeliveries(motoboy: motoboy);
  }
}
