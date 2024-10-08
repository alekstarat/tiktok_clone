part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

final class InitialHomeEvent extends HomeEvent {}

final class AddVideoEvent extends HomeEvent {}

final class LikeVideoEvent extends HomeEvent {
  final int id;

  LikeVideoEvent({required this.id});
}

final class AddCommentEvent extends HomeEvent {

  final CommentModel comment;

  AddCommentEvent({required this.comment});

}

final class SaveVideoEvent extends HomeEvent {}

final class ShareVideoEvent extends HomeEvent {}
