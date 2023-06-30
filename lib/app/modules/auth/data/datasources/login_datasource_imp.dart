import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/auth/data/datasources/login_datasource.dart';
import 'package:astronautas_app/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginDatasourceImp implements LoginDatasource {
  @override
  Future<Either<Failure, bool>> call({required LoginParams params}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: params.email, password: params.password);

      String? thisDeviceToken = await FirebaseMessaging.instance.getToken();

      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(params.email)
          .update({
        "tokens": [thisDeviceToken],
      });

      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e));
    }
  }
}
