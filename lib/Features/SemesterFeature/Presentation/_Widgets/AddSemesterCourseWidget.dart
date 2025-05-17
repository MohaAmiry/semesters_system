import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Features/SemesterFeature/Presentation/AddSemester/Enitities/AddSemesterCourseEntity.dart';

import '../../../../utils/Resouces/ColorManager.dart';

class AddSemesterCourseWidget extends ConsumerWidget {
  final AddSemesterCourseEntity course;
  final Function removeFunc;

  const AddSemesterCourseWidget(
      {super.key, required this.course, required this.removeFunc});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => removeFunc(),
                  icon: const Icon(
                    Icons.remove,
                    color: ColorManager.error,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(course.course!.courseName,
                      style: Theme.of(context).textTheme.titleMedium),
                  Text(course.course!.courseNumber),
                ],
              ),
              Text("ساعات المادة: ${course.course!.hours}"),
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
                  ? const Text("لا توجد محاضرات نظري")
                  : Column(
                      children: course.practicalTime
                          .map(
                            (element) => Text(element.toString()),
                          )
                          .toList(),
                    ),
            ],
          )),
    );
  }
}
