import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semester_system/utils/Extensions.dart';

import '../../../ExceptionHandler/MessageEmitter.dart';
import '../../../ExceptionHandler/MessageTypes.dart';
import '../../../utils/SharedOperations.dart';
import '../../_Shared/AbstractDataRepository.dart';
import '../Domain/User/UserRole.dart';
import 'RequestsModels/LoginRequest/LoginEntityRequest.dart';
import 'RequestsModels/RegisterRequestsModels/RegisterRequest.dart';

part 'AuthController.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController with SharedUserOperations {
  @override
  FutureOr<UserRole?> build() async {
    try {
      return await ref
          .read(repositoryClientProvider)
          .authRepository
          .getUserTypeDoc();
    } on Exception {
      return null;
    }
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    ref
        .read(messageEmitterProvider.notifier)
        .setMessage(PendingMessage("انتظار الدخول"));

    state = await AsyncValue.guard(() async => ref
        .read(repositoryClientProvider)
        .authRepository
        .signIn(LoginRequest(email: email, password: password)));
    if (state.hasError) {
      ref
          .read(messageEmitterProvider.notifier)
          .setMessage(FailedMessage(Exception("${state.error}")));
      state = const AsyncData(null);
      return;
    }
    if (state.hasValue) {
      state.requireValue != null
          ? ref
              .read(messageEmitterProvider.notifier)
              .setMessage(SuccessfulMessage("تم تسجيل الدخول"))
          : null;
    }
  }

  bool validateRegisterRequest(RegisterRequest request) {
    if (!isValidUserName(request.name)) {
      ref
          .read(messageEmitterProvider.notifier)
          .setMessage(FailedMessage(Exception("الأسم فارغ")));
      return false;
    }
    if (!isValidEmail(request.email)) {
      ref
          .read(messageEmitterProvider.notifier)
          .setMessage(FailedMessage(Exception("ليس شكل إيميل")));
      return false;
    }
    if (!isValidPassword(request.password)) {
      ref
          .read(messageEmitterProvider.notifier)
          .setMessage(FailedMessage(Exception("كلمة المرور اقل من 6 محارف")));
      return false;
    }
    if (request.universityId.isEmpty) {
      ref
          .read(messageEmitterProvider.notifier)
          .setMessage(FailedMessage(Exception("الرقم الجامعي فارغ")));
      return false;
    }
    return true;
  }

  Future<void> signUp(RegisterRequest request) async {
    var valid = validateRegisterRequest(request);
    if (!valid) return;
    await ref.operationPipeLine(
        func: () =>
            ref.read(repositoryClientProvider).authRepository.signUp(request));
  }

  Future<void> signOut() async {
    await ref.read(repositoryClientProvider).authRepository.signOut();
    state = const AsyncData(null);
  }
}
