import 'package:mobx_triple/mobx_triple.dart';
import 'package:tripleintoxianimeapi/modules/home/models/anime_model.dart';
import 'package:tripleintoxianimeapi/modules/home/post_state.dart';
import 'package:tripleintoxianimeapi/modules/home/usecases/get_initial_posts.dart';
import 'package:tripleintoxianimeapi/modules/home/usecases/get_posts.dart';
import 'package:tripleintoxianimeapi/utils/failure.dart';

// ignore: must_be_immutable
class AnimeController extends MobXStore<ErrorPostState, PostState> {
  AnimeController(this.getInitialPostsUsecase, this.getPostsUsecase)
      : super(InitialPostState());

  final GetInitialPosts getInitialPostsUsecase;
  final GetPosts getPostsUsecase;

  List<AnimePost> posts = [];

  Future<void> getInitialPosts() async {
    final usecase = await getInitialPostsUsecase();
    setLoading(true);

    usecase.fold(
      (error) {
        if (error is ForbiddenFailure) {
          setError(ErrorPostState(
              "Não foi possível carregar os posts iniciais. - ${error.message}"));
        }
      },
      (listaDePosts) {
        posts = listaDePosts;
        update(SuccessPostState(posts));
        setLoading(false);
      },
    );
  }

  int _page = 1;
  _incrementPage() => _page++;

  Future<void> getPosts() async {
    if (_page < 200) _incrementPage();
    final usecase = await getPostsUsecase(page: _page);

    usecase.fold(
      (error) {
        if (error is ForbiddenFailure) {
          setError(ErrorPostState(
              "Não foi possível carregar os posts iniciais. - ${error.message}"));
        }
      },
      (novosPosts) {
        posts.addAll(novosPosts);
        update(SuccessPostState(posts));
      },
    );
  }
}
