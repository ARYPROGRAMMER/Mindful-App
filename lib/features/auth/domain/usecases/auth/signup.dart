import 'package:mental_health/core/usecase/usecase.dart';
import 'package:mental_health/features/auth/data/models/auth/create_user_request.dart';
import 'package:dartz/dartz.dart';
import 'package:mental_health/features/auth/domain/repositories/auth/auth.dart';
import 'package:mental_health/injections.dart';

class SignupUseCase implements Usecase<Either, CreateUserRequest> {
  @override
  Future<Either> call({CreateUserRequest? params}) {
    // TODO: implement call

    return sl<AuthRepository>().signup(params!);
  }
}
