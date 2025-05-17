import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Features/SemesterFeature/Presentation/_Widgets/CourseWidget.dart';
import 'package:semester_system/Features/_Shared/UtilsViews/ErrorView.dart';
import 'package:semester_system/Features/_Shared/UtilsViews/LoadingView.dart';
import 'package:semester_system/Router/MyRoutes.gr.dart';

import '../../../../utils/Resouces/ColorManager.dart';
import '../../../../utils/Resouces/ValuesManager.dart';
import '../../../AuthenticationFeature/Data/AuthController.dart';
import '../../../AuthenticationFeature/Domain/User/UserRole.dart';
import 'Notifiers/AllCoursesProvider.dart';

@RoutePage()
class AllCoursesView extends ConsumerWidget {
  const AllCoursesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(authControllerProvider).requireValue;
    return Scaffold(
      appBar: AppBar(
        title: const Text("قائمة المواد"),
        actions: [
          if (user is Admin)
            IconButton(
                onPressed: () => context.router.push(const AddCourseRoute()),
                icon: const Icon(Icons.add))
        ],
      ),
      backgroundColor: ColorManager.surface,
      body: Padding(
        padding: const EdgeInsets.all(PaddingValuesManager.p20),
        child: ref.watch(allCoursesProvider).when(
              data: (data) => ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) =>
                    CourseWidget(course: data.elementAt(index)),
              ),
              error: (error, stackTrace) => ErrorView(error: error),
              loading: () => const LoadingView(),
            ),
      ),
    );
  }
}
