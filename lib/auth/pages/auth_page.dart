import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:tiktok_clone/auth/pages/login_page.dart';
import 'package:tiktok_clone/auth/pages/registration_page.dart';
import 'package:tiktok_clone/components/loading_screen.dart';
import 'package:tiktok_clone/packages/auth_repository/auth_repository_impl.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool signIn = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => context.read<AuthBloc>(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final authBloc = context.read<AuthBloc>();
          print("isClosed: ${authBloc.isClosed}");
          print(state);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.question_circle,
                          color: Colors.black.withOpacity(0.6),
                          size: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            authBloc.add(AuthCanceled());
                            Navigator.pop(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const HomeScreen()));
                          },
                          child: Text("Пропустить",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontFamily: 'PTSans',
                                  fontSize: 15)),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Text(
                        signIn ? "Вход" : "Регистрация",
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'PTSans',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                          signIn
                              ? "Управляйте своим аккаунтом, получайте уведомления, комментируйте видео, и другое."
                              : "Создайте профиль, следите за другими аккаунтами, создавайте собственные видео, и другое.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontFamily: 'PTSans',
                              fontSize: 15)),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          print("signIn: $signIn");
                          print("isClosed: ${authBloc.isClosed}");
                          authBloc
                              .add(signIn ? LoginEvent() : RegistrationEvent());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => RepositoryProvider(
                                        create: (_) => context.read<AuthRepository>(),
                                        child: BlocProvider(
                                            create: (_) =>
                                                context.read<AuthBloc>(),
                                            child: signIn
                                                ? const LoginPage()
                                                : const RegistrationPage()),
                                      )));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: kToolbarHeight - 5,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey[100]!, width: 2),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(CupertinoIcons.person,
                                    color: Colors.black, size: 30),
                                Text(
                                    signIn
                                        ? "Телефон / Почта / Имя польз."
                                        : "Телефон или эл. почта",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'PTSans',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  width: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: kToolbarHeight - 5,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[100]!, width: 2),
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.facebook,
                                  color: Colors.blue[900], size: 30),
                              const Text("Продолжить через Facebook",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'PTSans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                width: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: kToolbarHeight - 5,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[100]!, width: 2),
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.g_translate_outlined,
                                  color: Colors.blue[900], size: 30),
                              const Text("Продолжить через Google",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'PTSans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                width: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(32),
                            child: Text.rich(
                              TextSpan(
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: 12),
                                  children: const <TextSpan>[
                                    TextSpan(
                                        text: "Продолжая, вы соглашаетесь с "),
                                    TextSpan(
                                        text: "Правилами сервиса",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: " и тем, что прочитали нашу "),
                                    TextSpan(
                                        text: "Политику Приватности",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            ", чтобы понять, как мы собираем, используем и делимся вашими данными"),
                                  ]),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                signIn = !signIn;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: kToolbarHeight,
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    signIn
                                        ? "Нет аккаунта? "
                                        : "Уже есть аккаунт? ",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  Text(
                                    signIn ? "Регистрация" : "Войти",
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (state is AuthLoadingState)
                    Container(
                        color: Colors.black.withOpacity(0.7),
                        child: const Center(child: LoadingScreen()))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
