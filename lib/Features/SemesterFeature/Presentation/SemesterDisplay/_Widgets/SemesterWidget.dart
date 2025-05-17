import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/Semester.dart';
import 'package:semester_system/utils/Resouces/ColorManager.dart';

import '../../../../../Router/MyRoutes.gr.dart';

class SemesterWidget extends ConsumerWidget {
  final Semester semester;

  const SemesterWidget({super.key, required this.semester});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("رقم الفصل: ${semester.semesterNumber}",
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const Divider(),
            Text(
                "عدد ساعات الفصل الأفصى: ${semester.isSummerSemester ? '12' : '18'}",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: ColorManager.secondary)),
            InkWell(
                onTap: () => context.router
                    .push(SemesterStudentsRoute(semester: semester)),
                child: Text(
                    "عدد الطلاب المسجلين بالفصل: ${semester.students.length}",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: ColorManager.secondary))),
            InkWell(
              onTap: () => context.router
                  .push(SemesterCoursesRoute(courses: semester.courses)),
              child: Text(
                  "عدد المواد المسجلة بالفصل: ${semester.courses.length}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: ColorManager.secondary)),
            )
          ],
        ),
      ),
    );
  }
}
