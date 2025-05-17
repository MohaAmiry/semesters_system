import 'package:auto_route/annotations.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/Resouces/ColorManager.dart';
import '../../../Domain/SemesterCourse.dart';
import '../../_Widgets/SemesterCourseWidget.dart';

@RoutePage()
class SemesterCoursesView extends ConsumerWidget {
  final IList<SemesterCourse> courses;

  const SemesterCoursesView({super.key, required this.courses});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("مواد الفصل"),
      ),
      backgroundColor: ColorManager.surface,
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) => SemesterCourseWidget(
          course: courses.elementAt(index),
        ),
      ),
    );
  }
}
