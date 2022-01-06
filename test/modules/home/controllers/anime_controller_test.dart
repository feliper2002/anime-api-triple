import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mocktail/mocktail.dart';
import 'package:triple_test/triple_test.dart';
import 'package:tripleintoxianimeapi/modules/home/controllers/anime_controller.dart';
import 'package:tripleintoxianimeapi/modules/home/models/anime_model.dart';
import 'package:tripleintoxianimeapi/modules/home/post_state.dart';
import 'package:tripleintoxianimeapi/modules/home/repository/anime_repository.dart';

class AnimeRepositoryMock extends Mock implements AnimeRepository {}

void main() {
  final repository = AnimeRepositoryMock();

  storeTest<AnimeController>(
    'Should return a SuccessPostState with AnimePost list',
    build: () {
      when(() => repository.getAnimePost())
          .thenAnswer((_) async => <AnimePost>[]);
      return AnimeController(repository);
    },
    act: (controller) => controller.getInitialPosts(),
    expect: () => [
      isA<InitialPostState>(),
      tripleLoading,
      isA<SuccessPostState>(),
      false,
    ],
  );

  storeTest<AnimeController>(
    'Should return a SuccessPostState with AnimePost list increment page',
    build: () {
      when(() => repository.getAnimePost())
          .thenAnswer((_) async => <AnimePost>[]);
      return AnimeController(repository);
    },
    act: (controller) => controller.getPosts(),
    expect: () => [
      isA<InitialPostState>(),
      true,
      isA<SuccessPostState>(),
      false,
    ],
  );
}
