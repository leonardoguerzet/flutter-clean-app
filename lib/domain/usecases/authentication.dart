import 'package:meta/meta.dart';

import '../entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams {
  String email;
  String secret;

  AuthenticationParams({
    @required this.email,
    @required this.secret,
  });
}
