import 'package:mobx_triple/mobx_triple.dart';
import 'package:tripleintoxianimeapi/modules/home/models/anime_model.dart';
import 'package:tripleintoxianimeapi/modules/home/post_state.dart';
import 'package:tripleintoxianimeapi/modules/home/repository/anime_repository.dart';

class AnimeController extends MobXStore<ErrorPostState, PostState> {
  AnimeController(this.repository) : super(InitialPostState());

  final AnimeRepository repository;

  late List<AnimePost> posts;

  Future<void> getInitialPosts() async {
    setLoading(true);

    try {
      posts = await repository.getAnimePost();
      update(SuccessPostState(posts));
    } catch (e) {
      setError(ErrorPostState(e.toString()));
    }
  }

  int _page = 1;
  _incrementPage() => _page++;

  Future<void> getPosts() async {
    setLoading(true);
    late List<AnimePost> newPosts;

    if (_page < 200) _incrementPage();
    try {
      newPosts = await repository.getAnimePost(_page);
      posts.addAll(newPosts);
      update(SuccessPostState(posts));
    } catch (e) {
      setError(ErrorPostState(e.toString()));
    }
  }
}
