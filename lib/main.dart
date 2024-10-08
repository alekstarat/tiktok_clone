import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/components/loading_screen.dart';
import 'package:tiktok_clone/packages/auth_repository/auth_repository_impl.dart';
import 'package:tiktok_clone/packages/user_repository/user_repository_impl.dart';
import 'package:tiktok_clone/pages/home_screen/home_bloc/home_bloc.dart';
import 'package:tiktok_clone/pages/home_screen/home_screen.dart';
import 'package:tiktok_clone/restart_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(RestartWidget(
    child: MaterialApp(
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
      home: const SplashPage()
    ),
  ));
}



class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 600),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainApp()),
          (route) => false,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/images/BCLogo.png', width: MediaQuery.of(context).size.width/2,),
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final AuthRepository authRepo = const AuthRepository();
  late final UserRepository userRepo;
  late final SharedPreferences _prefs;
  bool prefsLoaded = false;

  @override
  void initState() {
    
    super.initState();
    SharedPreferences.getInstance().then((v) {
      setState(() {
        _prefs = v;
        print("prefs loaded");
        userRepo = UserRepository(_prefs);
        userRepo.userId = _prefs.getInt("userId");
        prefsLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
          RepositoryProvider(
            create: (_) => authRepo,
          ),
          RepositoryProvider(
            create: (_) => userRepo,
          ),
        ],
      child: prefsLoaded
                ? MultiBlocProvider(
                    providers: [
                        BlocProvider(
                                  create: (_) =>
                                      AuthBloc(authRepo: authRepo, userRepo: userRepo)
                                        ..add(AuthInitialEvent()),
                
                                  ),
                        BlocProvider(
                            create: (_) => HomeBloc(userRepo: userRepo),
                        ),
                    ],
                    child: const HomeScreen(),
                                    //   child: BlocBuilder<AuthBloc, AuthState>(
                                    // builder: (context, state) {
                                    //   if (state is! AuthenticatedState) {
                                    //     return const AuthPage();
                                    //   } else {
                                    //     return RepositoryProvider(
                                    //       create: (_) => context.read<UserRepository>(),
                                    //       child: const HomeScreen(),
                                    //     );
                                    //   }
                                    // },
                )
                : const Center(child: LoadingScreen()),
          );
    
  }
}
