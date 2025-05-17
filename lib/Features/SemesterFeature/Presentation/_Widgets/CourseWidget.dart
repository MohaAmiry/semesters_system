import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/Course.dart';
import 'package:semester_system/utils/Resouces/ColorManager.dart';

class CourseWidget extends ConsumerWidget {
  final Course course;

  const CourseWidget({super.key, required this.course});

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
                  Text(course.courseName,
                      style: Theme.of(context).textTheme.titleMedium),
                  Text(course.courseNumber),
                ],
              ),
              Text("ساعات المادة: ${course.hours}"),
              const Divider(),
              Text(
                "المتطلبات السابقة",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              if (course.preRequisites.isEmpty)
                Text("لا يوجد",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorManager.onSurfaceVariant1LightRedPink)),
              for (int i = 0; i < course.preRequisites.length; i++)
                Text(
                  course.preRequisites.elementAt(i).overViewString,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorManager.onSurfaceVariant1LightRedPink),
                )
            ],
          )),
    );
  }
}
