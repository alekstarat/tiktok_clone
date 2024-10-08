import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tiktok_clone/packages/models/comment_model.dart';
import 'package:tiktok_clone/packages/models/video_model.dart';
import 'package:tiktok_clone/packages/user_repository/user_repository_impl.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final UserRepository _userRepository;

  List<VideoModel> loadedVideos = [];

  HomeBloc({
    required UserRepository userRepo,
  }) : _userRepository = userRepo,
    super(HomeLoading()) {
    on<LikeVideoEvent>((event, emit) {
      print(userRepo.user);
    });
  }
}
