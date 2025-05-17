import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'MessageTypes.dart';

part 'MessageEmitter.g.dart';

@riverpod
class MessageEmitter extends _$MessageEmitter {
  @override
  Message? build() {
    return null;
  }

  void setMessage(Message? message) => state = message;

  void setPending({String? message}) =>
      setMessage(PendingMessage(message ?? "العملية قيد الانتظار"));

  void setFailed({required Exception message}) =>
      setMessage(FailedMessage(message));

  void setSuccessfulMessage({String? message}) =>
      setMessage(SuccessfulMessage(message ?? "نجحت العملية"));
}
