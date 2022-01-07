import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tripleintoxianimeapi/modules/home/models/anime_model.dart';
import 'package:tripleintoxianimeapi/modules/home/repository/anime_repository.dart';
import 'package:tripleintoxianimeapi/utils/failure.dart';

abstract class GetInitialPosts {
  Future<Either<Failure, List<AnimePost>>> call();
}

class GetInitialPostsImpl implements GetInitialPosts {
  final AnimeRepository repository;

  GetInitialPostsImpl(this.repository);

  @override
  Future<Either<Failure, List<AnimePost>>> call() async {
    try {
      final posts = await repository.getAnimePost();
      return Right(posts);
    } on DioError catch (e) {
      return Left(ForbiddenFailure("Erro no consumo da API. - ${e.message}"));
    }
  }
}
