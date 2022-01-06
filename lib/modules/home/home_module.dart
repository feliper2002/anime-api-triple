import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tripleintoxianimeapi/modules/home/controllers/anime_controller.dart';
import 'package:tripleintoxianimeapi/modules/home/repository/anime_repository.dart';
import 'package:tripleintoxianimeapi/modules/home/view/content.page.dart';

import 'view/home.page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<Dio>((i) => Dio()),
        Bind<AnimeRepositoryFTeam>((i) => AnimeRepositoryFTeam(i.get<Dio>())),
        Bind<AnimeController>(
            (i) => AnimeController(i.get<AnimeRepositoryFTeam>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const HomePage()),
        ChildRoute('/content',
            child: (_, args) => ContentPage(
                title: args.data['title'], content: args.data['content'])),
      ];
}
