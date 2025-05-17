import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/ScheduleCourseTimes.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/Time.dart';

class ScheduleDayWidget extends ConsumerWidget {
  final IList<ScheduleCourseTime> coursesTimes;

  const ScheduleDayWidget({super.key, required this.coursesTimes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < Day.values.length; i++)
          buildSingleDay(context, Day.values.elementAt(i))
      ],
    );
  }

  Widget buildSingleDay(BuildContext context, Day day) {
    final filteredTimes = coursesTimes
        .where((course) => course.time.day == day)
        .toIList()
        .sort((a, b) =>
            a.time.from.comparableDate.compareTo(b.time.from.comparableDate));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(day.name, style: Theme.of(context).textTheme.titleMedium),
        if (filteredTimes.isEmpty) const Text("--"),
        if (filteredTimes.isNotEmpty)
          for (int i = 0; i < filteredTimes.length; i++)
            Text(filteredTimes.elementAt(i).toString())
      ],
    );
  }
}
