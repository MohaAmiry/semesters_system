import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Features/AuthenticationFeature/Data/AuthController.dart';
import 'package:semester_system/Features/AuthenticationFeature/Domain/User/UserRole.dart';
import 'package:semester_system/utils/Resouces/ColorManager.dart';

import '../../../Domain/SemesterStudent.dart';
import '../_Notifiers/SemesterNotifier.dart';

class SemesterStudentCourseWidget extends ConsumerWidget {
  final String studentId;
  final String semesterId;
  final ({int studentIndex, int courseIndex}) studentCourseInfo;
  final IList<SemesterStudent> students;

  const SemesterStudentCourseWidget(
      {super.key,
      required this.studentCourseInfo,
      required this.studentId,
      required this.students,
      required this.semesterId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var provider = ref.watch(semesterNotifierProvider(students: students));
    var course = provider
        .elementAt(studentCourseInfo.studentIndex)
        .selectedCourses
        .elementAt(studentCourseInfo.courseIndex);
    final user = ref.watch(authControllerProvider).requireValue;

    return Card(
      color: course.didPass == null
          ? null
          : course.didPass!
              ? ColorManager.onSurfaceVariant1LightGreen
              : ColorManager.onSurfaceVariant1LightRedPink,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(course.course.course.courseName,
                    style: Theme.of(context).textTheme.titleMedium),
                Text(course.course.course.courseNumber),
              ],
            ),
            Text("ساعات المادة: ${course.course.course.hours}"),
            const Divider(),
            Text("المحاضرات النظري",
                style: Theme.of(context).textTheme.headlineMedium),
            Column(
              children: course.course.theoryTime
                  .map(
                    (element) => Text(element.toString()),
                  )
                  .toList(),
            ),
            Text("المحاضرات العملي",
                style: Theme.of(context).textTheme.headlineMedium),
            course.course.practicalTime.isEmpty
                ? const Text("لا توجد محاضرات نظري")
                : Column(
                    children: course.course.practicalTime
                        .map(
                          (element) => Text(element.toString()),
                        )
                        .toList(),
                  ),
            Align(
              alignment: Alignment.centerLeft,
              child: user is Student
                  ? Text(
                      "حالة نجاح المادة: ${course.didPass == null ? "غير محدد" : course.didPass! ? "ناجح" : "راسب"}")
                  : course.didPass == null
                      ? Row(
                          children: [
                            TextButton(
                                onPressed: () async => await ref
                                    .read(SemesterNotifierProvider(
                                            students: students)
                                        .notifier)
                                    .changeCourseStatusForStudent(
                                        studentId: studentId,
                                        semesterId: semesterId,
                                        courseId: course.course.course.courseId,
                                        didPass: true),
                                child: const Text("ناجح")),
                            TextButton(
                                onPressed: () async => await ref
                                    .read(SemesterNotifierProvider(
                                            students: students)
                                        .notifier)
                                    .changeCourseStatusForStudent(
                                        studentId: studentId,
                                        semesterId: semesterId,
                                        courseId: course.course.course.courseId,
                                        didPass: false),
                                child: const Text("راسب"))
                          ],
                        )
                      : Text(
                          "حالة نجاح المادة: ${course.didPass! ? "ناجح" : "راسب"}"),
            )
          ],
        ),
      ),
    );
  }
}
