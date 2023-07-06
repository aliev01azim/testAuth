abstract class ExceptionImpl implements Exception {
  final String text;
  const ExceptionImpl({this.text = "Произошла ошибка"});
}

class RegisterRequestFailure extends ExceptionImpl {
  const RegisterRequestFailure({super.text});
}

class LoginRequestFailure extends ExceptionImpl {
  const LoginRequestFailure({super.text});
}

class ProfileRequestFailure extends ExceptionImpl {
  const ProfileRequestFailure({super.text});
}
