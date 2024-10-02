part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthenticatedState extends AuthState {

  final UserModel userModel;

  AuthenticatedState({required this.userModel});

}

final class AuthLoadingState extends AuthState {}

final class UnauthenticatedState extends AuthState {}

final class AuthProgressState extends AuthState {}

final class UnknownState extends AuthState {

  final String? error;

  UnknownState({this.error});
}
