import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:triple_test/triple_test.dart';
import 'package:tripleintoxianimeapi/modules/home/controllers/anime_controller.dart';
import 'package:tripleintoxianimeapi/modules/home/post_state.dart';

class AnimeControllerMock extends MockStore<ErrorPostState, PostState>
    implements AnimeController {}

void main() {
  final controller = AnimeControllerMock();

  whenObserve(
    controller,
    input: () => controller.getInitialPosts(),
    initialState: InitialPostState,
    triples: [
      Triple(state: SuccessPostState),
    ],
  );

  storeTest<AnimeControllerMock>(
    'Testando',
    build: () => AnimeControllerMock(),
    act: (controller) => controller.getInitialPosts(),
    expect: () => [
      SuccessPostState,
    ],
  );
}
