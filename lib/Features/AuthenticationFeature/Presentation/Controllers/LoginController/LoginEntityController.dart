import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../utils/SharedOperations.dart';
import '../../../Data/RequestsModels/LoginRequest/LoginEntityRequest.dart';

part 'LoginEntityController.g.dart';

@riverpod
class LoginEntityController extends _$LoginEntityController
    with SharedUserOperations {
  @override
  LoginRequest build() {
    return const LoginRequest(email: "", password: "");
  }

  void setEmail(String newMailVal) => state = state.copyWith(email: newMailVal);

  void setPassword(String newPassVal) =>
      state = state.copyWith(password: newPassVal);
}
