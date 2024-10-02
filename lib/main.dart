import 'package:flutter/material.dart';
import 'package:tiktok_clone/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:tiktok_clone/auth/pages/auth_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/packages/auth_repository/auth_repository_impl.dart';
import 'package:tiktok_clone/packages/user_repository/user_repository_impl.dart';
import 'package:tiktok_clone/pages/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final AuthRepository authRepo = const AuthRepository();
  final UserRepository userRepo = UserRepository()..initPrefs();
  Widget? nextPage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          splashColor: Colors.transparent,
          fontFamily: 'PTSans',
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
        ),
        debugShowCheckedModeBanner: false,
        home: RepositoryProvider.value(
          value: authRepo,
          child: BlocProvider(
              lazy: false,
              create: (_) => AuthBloc(authRepo: authRepo, userRepo: userRepo)
                ..add(AuthInitialEvent()),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is! AuthenticatedState) {
                    return const AuthPage();
                  } else {
                    return const HomeScreen();
                  }
                    
                },
              )),
        ));
  }
}
