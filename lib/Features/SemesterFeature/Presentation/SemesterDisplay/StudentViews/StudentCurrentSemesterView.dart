import 'package:auto_route/auto_route.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Features/AuthenticationFeature/Data/AuthController.dart';
import 'package:semester_system/Features/SemesterFeature/Presentation/SemesterDisplay/_Widgets/SemesterStudentCourseWidget.dart';
import 'package:semester_system/Features/SemesterFeature/Presentation/SemesterDisplay/_Widgets/SemesterStudentWidget.dart';
import 'package:semester_system/Features/_Shared/UtilsViews/ErrorView.dart';
import 'package:semester_system/Features/_Shared/UtilsViews/LoadingView.dart';
import 'package:semester_system/Router/MyRoutes.gr.dart';

import '../../../../../ExceptionHandler/MessageController.dart';
import '../../../../../ExceptionHandler/MessageEmitter.dart';
import '../../../../../utils/Resouces/ColorManager.dart';
import '../../../../../utils/Resouces/ValuesManager.dart';
import '../../../Domain/SemesterStudent.dart';
import '../_Notifiers/StudentCurrentSemesterNotifier.dart';

@RoutePage()
class StudentCurrentSemesterView extends ConsumerWidget {
  const StudentCurrentSemesterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen(messageEmitterProvider, (previous, next) {
        if (next == null) {
          return;
        }
        ref.read(MessageControllerProvider(context).notifier).showToast(next);
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
          title: const Text("الفصل الحالي"),
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Column(
              children: [
                studentButtonsWidget(context),
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
        body: ref.watch(studentCurrentSemesterProvider).when(
              data: (data) => SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(PaddingValuesManager.p20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SemesterStudentWidget(
                        studentIndex: 0,
                        students: IList([data]),
                      ),
                      const Divider(),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.selectedCourses.length,
                          itemBuilder: (context, index) =>
                              SemesterStudentCourseWidget(
                                  students: IList([data]),
                                  studentCourseInfo: (
                                    studentIndex: 0,
                                    courseIndex: index
                                  ),
                                  studentId: data.studentId,
                                  semesterId: data.semesterId))
                    ],
                  ),
                ),
              ),
              error: (error, stackTrace) => ErrorView(error: error),
              loading: () => const LoadingView(),
            ));
  }

  Widget studentInfo(SemesterStudent student) => Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text("${student.studentName}اسم الطالب: "),
              Text("${student.universityId}رقم الطالب الجامعي: "),
              Text("بيانات المواد"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("عدد المواد المسجلة"),
                      Text(student.selectedCourses.length.toString())
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("عدد المواد الناجحة"),
                      Text(student.selectedCourses
                          .where((element) => element.didPass ?? false)
                          .length
                          .toString())
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("عدد المواد الراسبة"),
                      Text(student.selectedCourses
                          .where((element) => !(element.didPass ?? true))
                          .length
                          .toString())
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      );

  Widget studentButtonsWidget(BuildContext context) => Column(
        children: [
          TextButton(
              onPressed: () =>
                  context.router.push(const StudentSemesterRegisterRoute()),
              child: const Text("التسجيل بالفصل الجديد")),
          TextButton(
              onPressed: () => context.router.push(const AllCoursesRoute()),
              child: const Text("قائمة المواد")),
          TextButton(
              onPressed: () =>
                  context.router.push(const StudentSuccessCoursesRoute()),
              child: const Text("قائمة المواد التي تم اجتيازها"))
        ],
      );
}
