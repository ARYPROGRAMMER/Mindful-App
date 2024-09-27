import 'package:dartz/dartz.dart';
import 'package:mental_health/features/auth/data/models/auth/create_user_request.dart';
import 'package:mental_health/features/auth/data/models/auth/signin_user_req.dart';
import 'package:mental_health/features/auth/data/sources/auth/auth_firebase_service.dart';
import 'package:mental_health/features/auth/domain/repositories/auth/auth.dart';
import 'package:mental_health/injections.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    return await sl<AuthFirebaseService>().signin(signinUserReq);
  }

  @override
  Future<Either> signup(CreateUserRequest createUserRequest) async {
    // TODO: implement signup
    return await sl<AuthFirebaseService>().signup(createUserRequest);
  }
}
