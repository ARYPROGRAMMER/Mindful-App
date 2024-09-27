class CreateUserRequest {
  final String fullName;
  final String email;
  final String password;

  CreateUserRequest(
      {required this.fullName, required this.email, required this.password});
}
