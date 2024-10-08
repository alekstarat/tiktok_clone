import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:tiktok_clone/restart_widget.dart';

class EnterPassword extends StatefulWidget {
  const EnterPassword({super.key});

  @override
  State<EnterPassword> createState() => _EnterPasswordState();
}

class _EnterPasswordState extends State<EnterPassword> {
  bool is8chars = false, obscure = true;
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      if (_passwordController.text.length >= 8 &&
          _passwordController.text.length <= 20) {
        setState(() {
          is8chars = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: BlocProvider(
          create: (_) => context.read<AuthBloc>(),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final authBloc = context.read<AuthBloc>();
              return BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthenticatedState) {
                    RestartWidget.restartApp(context);
                  }
                },
                child: GestureDetector(
                  onTap: () {
                    authBloc.authData
                        .addAll({"password": _passwordController.text});
                    authBloc.add(CheckAuthEvent());
                  },
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 100),
                    opacity: is8chars ? 1.0 : 0.4,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red[600],
                          borderRadius: BorderRadius.circular(8)),
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: kToolbarHeight - 5,
                      child: const Center(
                        child: Text(
                          "Продолжить",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.all(16),
            child: Icon(CupertinoIcons.question_circle,
                color: Colors.black, size: 25),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Введите пароль",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: kToolbarHeight - 10,
            child: CupertinoTextField(
              obscureText: obscure,
              suffixMode: OverlayVisibilityMode.editing,
              suffix: GestureDetector(
                onTap: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                child: const Icon(
                  Icons.remove_red_eye_rounded,
                  color: Colors.black,
                ),
              ),
              maxLength: 20,
              textAlignVertical: TextAlignVertical.center,
              placeholder: "Введите пароль",
              placeholderStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              controller: _passwordController,
              cursorColor: Colors.red[600],
              cursorWidth: 2,
              cursorRadius: const Radius.circular(90),
              cursorHeight: 20,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!, width: 1))),
            ),
          ),
        ]),
      ),
    );
  }
}
