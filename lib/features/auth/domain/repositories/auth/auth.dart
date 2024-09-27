import 'package:dartz/dartz.dart';
import 'package:mental_health/features/auth/data/models/auth/create_user_request.dart';
import 'package:mental_health/features/auth/data/models/auth/signin_user_req.dart';

abstract class AuthRepository {
  Future<Either> signup(CreateUserRequest createUserRequest);
  Future<Either> signin(SigninUserReq signinUserReq);
}
