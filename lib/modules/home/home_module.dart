import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tripleintoxianimeapi/modules/home/repository/anime_repository.dart';
import 'package:tripleintoxianimeapi/modules/home/usecases/get_initial_posts.dart';
import 'package:tripleintoxianimeapi/modules/home/usecases/get_posts.dart';

import 'presenter/controllers/anime_controller.dart';
import 'presenter/view/content.page.dart';
import 'presenter/view/home.page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<Dio>((i) => Dio()),
        Bind<AnimeRepositoryFTeam>((i) => AnimeRepositoryFTeam(i.get<Dio>())),
        Bind((i) => AnimeRepositoryFTeam(i.get())),
        Bind((i) => GetInitialPostsImpl(i.get())),
        Bind((i) => GetPostsImpl(i.get())),
        Bind<AnimeController>((i) => AnimeController(
            i.get<GetInitialPostsImpl>(), i.get<GetPostsImpl>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const HomePage()),
        ChildRoute('/content',
            child: (_, args) => ContentPage(
                title: args.data['title'], content: args.data['content'])),
      ];
}
