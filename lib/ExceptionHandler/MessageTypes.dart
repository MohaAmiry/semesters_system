sealed class Message {}

class SuccessfulMessage extends Message {
  String message;
  SuccessfulMessage(this.message);

  @override
  String toString() {
    return 'نجحت العملية: $message';
  }
}

class FailedMessage extends Message {
  Exception message;
  FailedMessage(this.message);

  @override
  String toString() {
    return "حدث خطأ:" + '$message';
  }
}

class PendingMessage extends Message {
  String message;
  PendingMessage(this.message);

  @override
  String toString() {
    return 'عملية قيد الانتظار: $message';
  }
}
