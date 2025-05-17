import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Router/MyRoutes.gr.dart';

import '../../../ExceptionHandler/MessageController.dart';
import '../../../ExceptionHandler/MessageEmitter.dart';
import '../../../utils/Resouces/ColorManager.dart';
import '../../../utils/Resouces/ValuesManager.dart';
import '../Data/AuthController.dart';
import '../Domain/User/UserRole.dart';
import '../_CommonWidgets/AuthButton.dart';
import 'Controllers/LoginController/LoginEntityController.dart';

@RoutePage()
class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController emailTextEdtController = TextEditingController();
  final TextEditingController passwordTextEdtController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = ref.watch(loginEntityControllerProvider);
    ref
      ..listen<AsyncValue<UserRole?>>(authControllerProvider, (previous, next) {
        next.whenData((data) {
          if (data == null) {
            return;
          }
          if (data is Admin) {
            context.router.replaceAll([const AllSemestersRoute()]);
            return;
          }
          context.router.replaceAll([const StudentCurrentSemesterRoute()]);
        });
      })
      ..listen(messageEmitterProvider, (previous, next) {
        next != null
            ? ref
                .read(MessageControllerProvider(context).notifier)
                .showToast(next)
            : null;
      });

    return Scaffold(
      backgroundColor: ColorManager.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(PaddingValuesManager.p20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * .1),
              //ref.watch(SvgLoaderProvider(ImageAssetsManager.logoIcon)),
              const SizedBox(height: AppSizeManager.s45),
              Text(
                "تسجيل الدخول",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSizeManager.s45),
              TextFormField(
                  controller: emailTextEdtController,
                  onChanged: (value) => ref
                      .read(loginEntityControllerProvider.notifier)
                      .setEmail(value),
                  decoration: const InputDecoration(
                      helperText: "",
                      labelText: "الإيميل",
                      hintText: "الإيميل")),
              TextFormField(
                  controller: passwordTextEdtController,
                  onChanged: (value) => ref
                      .read(loginEntityControllerProvider.notifier)
                      .setPassword(value),
                  decoration: const InputDecoration(
                      helperText: "",
                      labelText: "كلمة المرور",
                      hintText: "كلمة المرور")),
              AuthButton(
                  text: "تسجيل الدخول",
                  onPressed: () async => await ref
                      .read(authControllerProvider.notifier)
                      .signIn(emailTextEdtController.value.text,
                          passwordTextEdtController.value.text)),
            ],
          ),
        ),
      ),
    );
  }
}
