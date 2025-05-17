import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Features/SemesterFeature/Presentation/SemesterDisplay/_Widgets/SemesterWidget.dart';
import 'package:semester_system/Features/_Shared/UtilsViews/ErrorView.dart';
import 'package:semester_system/Features/_Shared/UtilsViews/LoadingView.dart';

import '../../../../../ExceptionHandler/MessageController.dart';
import '../../../../../ExceptionHandler/MessageEmitter.dart';
import '../../../../../Router/MyRoutes.gr.dart';
import '../../../../../utils/Resouces/ColorManager.dart';
import '../../../../AuthenticationFeature/Data/AuthController.dart';
import '../_Notifiers/AllSemestersProvider.dart';

@RoutePage()
class AllSemestersView extends ConsumerWidget {
  const AllSemestersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen(messageEmitterProvider, (previous, next) {
        if (next == null) {
          return;
        }
        ref.read(messageControllerProvider(context).notifier).showToast(next);
      })
      ..listen(
        authControllerProvider,
        (previous, next) {
          if (next.value == null) {
            context.router.replaceAll([const LoginRoute()]);
          }
        },
      );
    var user = ref.watch(authControllerProvider).requireValue;

    return Scaffold(
        appBar: AppBar(
          title: const Text("جميع الفصول"),
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Column(
              children: [
                adminButtonsWidget(context),
                TextButton(
                    onPressed: () =>
                        ref.read(authControllerProvider.notifier).signOut(),
                    child: const Text("تسجيل خروج")),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.2,
                        child: Image.asset("assets/Logo.png")),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: ColorManager.surface,
        body: ref.watch(allSemestersProvider).when(
            data: (data) => ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) =>
                    SemesterWidget(semester: data.elementAt(index))),
            error: (error, stackTrace) => ErrorView(error: error),
            loading: () => const LoadingView()));
  }

  Widget adminButtonsWidget(BuildContext context) => Column(
        children: [
          TextButton(
              onPressed: () => context.router.push(const AddSemesterRoute()),
              child: const Text("إضافة فصل جديد")),
          TextButton(
              onPressed: () =>
                  context.router.push(const RegisterNewStudentRoute()),
              child: const Text("تسجيل طالب جديد")),
          TextButton(
              onPressed: () => context.router.push(const AllCoursesRoute()),
              child: const Text("قائمة المواد"))
        ],
      );
}
