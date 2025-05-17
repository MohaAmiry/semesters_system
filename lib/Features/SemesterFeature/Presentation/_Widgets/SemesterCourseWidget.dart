import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/SemesterCourse.dart';

class SemesterCourseWidget extends ConsumerWidget {
  final SemesterCourse course;

  const SemesterCourseWidget({super.key, required this.course});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(course.course.courseName,
                    style: Theme.of(context).textTheme.titleMedium),
                Text(course.course.courseNumber),
              ],
            ),
            Text("ساعات المادة: ${course.course.hours}"),
            const Divider(),
            Text("المحاضرات النظري",
                style: Theme.of(context).textTheme.headlineMedium),
            Column(
              children: course.theoryTime
                  .map(
                    (element) => Text(element.toString()),
                  )
                  .toList(),
            ),
            Text("المحاضرات العملي",
                style: Theme.of(context).textTheme.headlineMedium),
            course.practicalTime.isEmpty
                ? const Text("لا توجد محاضرات عملي")
                : Column(
                    children: course.practicalTime
                        .map((element) => Text(element.toString()))
                        .toList(),
                  ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("السعة: ${course.studentsNumber}"))
          ],
        ),
      ),
    );
  }
}

class SemesterCourseSelectableWidget extends ConsumerWidget {
  final SemesterCourse course;
  final Color? color;

  const SemesterCourseSelectableWidget(
      {super.key, required this.course, required this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(course.course.courseName,
                    style: Theme.of(context).textTheme.titleMedium),
                Text(course.course.courseNumber),
              ],
            ),
            Text("ساعات المادة: ${course.course.hours}"),
            const Divider(),
            Text("المحاضرات النظري",
                style: Theme.of(context).textTheme.headlineMedium),
            Column(
                children: course.theoryTime
                    .map((element) => Text(element.toString()))
                    .toList()),
            Text("المحاضرات العملي",
                style: Theme.of(context).textTheme.headlineMedium),
            course.practicalTime.isEmpty
                ? const Text("لا توجد محاضرات عملي")
                : Column(
                    children: course.practicalTime
                        .map((element) => Text(element.toString()))
                        .toList(),
                  ),
            const Divider(),
            Text("المتطلبات السابقة",
                style: Theme.of(context).textTheme.headlineMedium),
            ...course.course.preRequisites.map(
              (element) => Text(element.overViewString),
            )
          ],
        ),
      ),
    );
  }
}
