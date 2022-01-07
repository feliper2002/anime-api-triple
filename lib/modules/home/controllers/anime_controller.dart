import 'package:dio/dio.dart';
import 'package:mobx_triple/mobx_triple.dart';
import 'package:tripleintoxianimeapi/modules/home/models/anime_model.dart';
import 'package:tripleintoxianimeapi/modules/home/post_state.dart';
import 'package:tripleintoxianimeapi/modules/home/repository/anime_repository.dart';

// ignore: must_be_immutable
class AnimeController extends MobXStore<ErrorPostState, PostState> {
  AnimeController(this.repository) : super(InitialPostState());

  final AnimeRepository repository;

  List<AnimePost> posts = [];

  Future<void> getInitialPosts() async {
    setLoading(true);
    try {
      posts = await repository.getAnimePost();
      update(SuccessPostState(posts));
    } catch (e) {
      setError(ErrorPostState(e.toString()));
    } finally {
      setLoading(false);
    }
  }

  int _page = 1;
  _incrementPage() => _page++;

  Future<void> getPosts() async {
    if (_page < 200) _incrementPage();
    try {
      posts.addAll(await repository.getAnimePost(page: _page));
      update(SuccessPostState(posts));
    } on DioError catch (e) {
      setError(ErrorPostState(e.message));
    }
  }
}
