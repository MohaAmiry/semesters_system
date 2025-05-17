import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../ExceptionHandler/MessageEmitter.dart';

extension StringExtension on String {
  String ifIsEmpty(String placeholder) => this.isEmpty ? placeholder : this;
}

extension ChatIDCombiner on List<String> {
  String constructChatID() {
    sort();
    return join("_");
  }
}

extension RefreshNotifiers<T> on AutoDisposeAsyncNotifier<T> {
  Future<void> myRefresh() async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    ref.invalidateSelf();
  }
}

extension Pipeline<T, R> on Ref<T> {
  Future<AsyncValue<R>> operationPipeLine<R>(
      {required Future<R> Function() func,
      String? pendingMessage,
      String? successMessage}) async {
    read(messageEmitterProvider.notifier).setPending(message: pendingMessage);
    var result = await AsyncValue.guard(func);
    if (result.hasError) {
      read(messageEmitterProvider.notifier)
          .setFailed(message: Exception(result.error.toString()));
      throw Exception(result.error);
    } else if (result.hasValue) {
      read(messageEmitterProvider.notifier)
          .setSuccessfulMessage(message: successMessage);
    }
    return result;
  }
}

extension DateExpension on DateTime {
  String toRegularDate() => DateFormat("yyyy/MM/dd").format(this);
  String toTime() {
    return DateFormat("HH:mm").format(this);
  }

  String toRegularDateWithTime() =>
      DateFormat('yyyy/MM/dd hh:mm:ss a').format(this);
}
