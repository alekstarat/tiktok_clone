part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

final class LoginEvent extends AuthEvent {}

final class LogoutEvent extends AuthEvent {}

final class RegistrationEvent extends AuthEvent {}

final class AuthCanceled extends AuthEvent {}

final class PreloadAuthEvent extends AuthEvent {}

final class CheckAuthEvent extends AuthEvent {}

final class AuthInitialEvent extends AuthEvent {}


