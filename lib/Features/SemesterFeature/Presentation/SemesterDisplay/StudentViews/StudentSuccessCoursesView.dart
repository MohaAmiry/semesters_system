import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Features/SemesterFeature/Presentation/_Widgets/CourseWidget.dart';
import 'package:semester_system/Features/_Shared/UtilsViews/ErrorView.dart';
import 'package:semester_system/Features/_Shared/UtilsViews/LoadingView.dart';

import '../../../../../utils/Resouces/ColorManager.dart';
import '../_Notifiers/StudentCurrentSemesterNotifier.dart';

@RoutePage()
class StudentSuccessCoursesView extends ConsumerWidget {
  const StudentSuccessCoursesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("المواد الناجحة"),
      ),
      backgroundColor: ColorManager.surface,
      body: ref.watch(studentSuccessCoursesProvider).when(
          data: (data) => ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) =>
                    CourseWidget(course: data.elementAt(index)),
              ),
          error: (error, stackTrace) => ErrorView(error: error),
          loading: () => const LoadingView()),
    );
  }
}
