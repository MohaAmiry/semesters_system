import 'package:dart_mappable/dart_mappable.dart';

part 'Time.mapper.dart';

@MappableClass()
class Time with TimeMappable {
  final int hour;
  final int minute;

  const Time({required this.hour, required this.minute});

  factory Time.empty() => const Time(hour: 0, minute: 0);

  factory Time.fromString(String time) {
    var s = time.split(":");
    return Time(
        hour: int.parse(s.elementAt(0)), minute: int.parse(s.elementAt(1)));
  }

  static bool isStartBeforeEnd(Time start, Time end) {
    return start.comparableDate.compareTo(end.comparableDate) == -1;
  }

  DateTime get comparableDate => DateTime(1, 1, 1, hour, minute);

  @override
  String toString() {
    return "$hour:$minute";
  }
}

@MappableClass()
class CourseTime with CourseTimeMappable {
  final Time from;
  final Time to;
  final Day day;

  const CourseTime({required this.from, required this.to, required this.day});

  factory CourseTime.empty() =>
      CourseTime(from: Time.empty(), to: Time.empty(), day: Day.saturday);

  bool doesIntersectWith(CourseTime other) {
    if (day != other.day) return false;
    if (to.comparableDate.isBefore(other.from.comparableDate) ||
        other.to.comparableDate.isBefore(from.comparableDate)) {
      return false;
    }
    return true;
  }

  @override
  String toString() {
    return "${day.name}, ${from.toString()} - ${to.toString()}";
  }
}

@MappableEnum()
enum Day {
  saturday("سبت"),
  sunday("أحد"),
  monday("إثنين"),
  tuesday("ثلاثاء"),
  wednesday("أربعاء"),
  thursday("خميس"),
  friday("جمعة");

  const Day(this.name);

  final String name;
}
