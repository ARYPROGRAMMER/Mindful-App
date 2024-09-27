import 'package:mental_health/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mental_health/features/auth/data/models/auth/signin_user_req.dart';

import 'package:mental_health/features/auth/domain/repositories/auth/auth.dart';
import 'package:mental_health/injections.dart';

class SigninUseCase implements Usecase<Either, SigninUserReq> {
  @override
  Future<Either> call({SigninUserReq? params}) {
    // TODO: implement call

    return sl<AuthRepository>().signin(params!);
  }
}
