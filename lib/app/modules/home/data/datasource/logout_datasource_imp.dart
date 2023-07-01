import 'package:astronautas_app/app/core/failure.dart';
import 'package:astronautas_app/app/modules/home/data/datasource/logout_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LogoutDatasourceImp implements LogoutDatasource {
  final FirebaseFirestore _db;
  final FirebaseAuth _auth;
  final FirebaseMessaging _messaging;

  LogoutDatasourceImp(this._db, this._auth, this._messaging);
  @override
  Future<Either<Failure, void>> call({required String email}) async {
    try {
      final userRef = _db.collection('usuarios').doc(email);
      List currentTokens =
          await userRef.get().then((value) => value.data()?['tokens'] ?? []);
      currentTokens.remove(await _messaging.getToken());
      userRef.update({
        'tokens': currentTokens,
      });
      await _auth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(Failure(error: e));
    }
  }
}
