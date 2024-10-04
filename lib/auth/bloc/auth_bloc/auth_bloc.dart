// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tiktok_clone/packages/auth_repository/auth_repository_impl.dart';
import 'package:tiktok_clone/packages/models/user_model.dart';
import 'package:tiktok_clone/packages/user_repository/user_repository_impl.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Map<String, String> authData = {};

  AuthBloc({
    required AuthRepository authRepo,
    required UserRepository userRepo,
  }) : _authRepository = authRepo,
      _userRepository = userRepo,
  super(UnauthenticatedState()) {
    on<AuthCanceled>((event, emit) {
      emit(UnauthenticatedState());
      print(UnauthenticatedState());
    });
    on<LoginEvent>((event, emit) {
      emit(AuthProgressState());
      print(AuthProgressState());
    });
    on<RegistrationEvent>((event, emit) {
      emit(AuthProgressState());
      print(AuthProgressState());
    });
    on<AuthInitialEvent>((event, emit) async {
      emit(AuthLoadingState());
      print(AuthLoadingState());
      try {
        await userRepo.getAuthenticatedUser(userRepo.userId!).then((v) {
          emit(AuthenticatedState(userModel: v!));
          print(AuthenticatedState);
        });
      } catch (e) {
        emit(UnauthenticatedState());
        print(UnauthenticatedState);
      }
    });
    on<CheckAuthEvent>((event, emit) async {
      emit(AuthLoadingState());
      print(AuthLoadingState());
        try {
          userRepo.user = await authRepo.signIn(
            authData.containsKey('login') ? authData['login'] : null,
            authData.containsKey('phone') ? authData['phone'] : null,
            authData.containsKey('email') ? authData['email'] : null,
            password: authData['password']!);
          emit(AuthenticatedState(userModel: userRepo.user!));
          print(AuthenticatedState);
          //_userRepository.setUser(prefs);
        } catch (e) {
          emit(UnknownState(error: e.toString()));
          print(UnknownState);
        
        }
      }  
    );
  }
}
