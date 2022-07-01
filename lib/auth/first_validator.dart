
import 'dart:async';

import 'package:conduit/conduit.dart';
import 'package:conduit/managed_auth.dart';
import 'package:conduit.'

class BasicValidator implements AuthValidator {
  @override
  FutureOr<Authorization> validate<T>(AuthorizationParser<T> parser, T authorizationData, {List<AuthScope> requiredScope}) async {
    var user = await userForName(usernameAndPassword.username);
    if (user.password == hash(usernameAndPassword.password, user.salt)) {
      return Authorization(...);
    }

    // Will end up creating a 401 Not Authorized Response
    return null;
    }
}
cd