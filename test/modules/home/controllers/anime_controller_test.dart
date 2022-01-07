import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:triple_test/triple_test.dart';
import 'package:tripleintoxianimeapi/modules/home/models/anime_model.dart';
import 'package:tripleintoxianimeapi/modules/home/post_state.dart';
import 'package:tripleintoxianimeapi/modules/home/presenter/controllers/anime_controller.dart';
import 'package:tripleintoxianimeapi/modules/home/repository/anime_repository.dart';
import 'package:tripleintoxianimeapi/modules/home/usecases/get_initial_posts.dart';
import 'package:tripleintoxianimeapi/modules/home/usecases/get_posts.dart';

class AnimeRepositoryMock extends Mock implements AnimeRepository {}

void main() {
  final repository = AnimeRepositoryMock();
  final getInitialPosts = GetInitialPostsImpl(repository);
  final getPosts = GetPostsImpl(repository);

  storeTest<AnimeController>(
    'Should return a SuccessPostState with AnimePost list',
    build: () {
      when(() => repository.getAnimePost())
          .thenAnswer((_) async => <AnimePost>[]);

      return AnimeController(getInitialPosts, getPosts);
    },
    act: (controller) => controller.getInitialPosts(),
    expect: () => [
      tripleState,
      tripleLoading,
      isA<SuccessPostState>(),
      false,
    ],
  );

  storeTest<AnimeController>(
    'Should return a SuccessPostState with AnimePost list increment page',
    build: () {
      when(() => repository.getAnimePost(page: 2))
          .thenAnswer((_) async => <AnimePost>[]);
      return AnimeController(getInitialPosts, getPosts);
    },
    act: (controller) => controller.getPosts(),
    expect: () => [
      isA<InitialPostState>(),
      isA<SuccessPostState>(),
    ],
  );
}
