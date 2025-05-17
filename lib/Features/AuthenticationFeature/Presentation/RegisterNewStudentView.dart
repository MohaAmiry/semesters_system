import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/Resouces/ColorManager.dart';
import '../../../../../utils/Resouces/ValuesManager.dart';
import '../Data/AuthController.dart';
import '../_CommonWidgets/AuthButton.dart';
import 'Controllers/RegisterController/RegisterAsStudentEntityController.dart';

@RoutePage()
class RegisterNewStudentView extends ConsumerStatefulWidget {
  const RegisterNewStudentView({super.key});

  @override
  ConsumerState createState() => _RegisterNewStudentViewState();
}

class _RegisterNewStudentViewState
    extends ConsumerState<RegisterNewStudentView> {
  final TextEditingController emailTextEdtController = TextEditingController();
  final TextEditingController passwordTextEdtController =
      TextEditingController();
  final TextEditingController universityIdController = TextEditingController();
  final TextEditingController nameTextEdtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = ref.watch(registerAsStudentEntityControllerProvider);
    return Scaffold(
      backgroundColor: ColorManager.surface,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(PaddingValuesManager.p20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * .1),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: PaddingValuesManager.p20,
                ),
                child: Text("تسجيل طالب جديد",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              const Divider(thickness: 1),
              const SizedBox(height: AppSizeManager.s20),
              TextFormField(
                  controller: nameTextEdtController,
                  onChanged: (value) => ref
                      .read(registerAsStudentEntityControllerProvider.notifier)
                      .setName(value),
                  decoration: const InputDecoration(
                      helperText: "", labelText: "الأسم", hintText: "الأسم")),
              TextFormField(
                  controller: emailTextEdtController,
                  onChanged: (value) => ref
                      .read(registerAsStudentEntityControllerProvider.notifier)
                      .setEmail(value),
                  decoration: const InputDecoration(
                      helperText: "",
                      labelText: "الإيميل",
                      hintText: "الإيميل")),
              TextFormField(
                  controller: universityIdController,
                  onChanged: (value) => ref
                      .read(registerAsStudentEntityControllerProvider.notifier)
                      .setUniversityId(value),
                  decoration: const InputDecoration(
                      helperText: "",
                      labelText: "الرقم الجامعي",
                      hintText: "الرقم الجامعي")),
              TextFormField(
                  controller: passwordTextEdtController,
                  onChanged: (value) => ref
                      .watch(registerAsStudentEntityControllerProvider.notifier)
                      .setPassword(value),
                  decoration: const InputDecoration(
                      helperText: "",
                      labelText: "كلمة المرور",
                      hintText: "كلمة المرور")),
              AuthButton(
                  text: "التسجيل",
                  onPressed: () {
                    var req =
                        ref.read(registerAsStudentEntityControllerProvider);
                    ref.read(authControllerProvider.notifier).signUp(req);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
