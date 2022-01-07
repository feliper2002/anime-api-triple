import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tripleintoxianimeapi/modules/home/models/anime_model.dart';
import 'package:tripleintoxianimeapi/modules/home/repository/anime_repository.dart';
import 'package:tripleintoxianimeapi/utils/failure.dart';

abstract class GetPosts {
  Future<Either<Failure, List<AnimePost>>> call(
      {int page = 1, int perPage = 10});
}

class GetPostsImpl implements GetPosts {
  final AnimeRepository repository;

  GetPostsImpl(this.repository);

  @override
  Future<Either<Failure, List<AnimePost>>> call(
      {int page = 1, int perPage = 10}) async {
    try {
      final posts = await repository.getAnimePost(page: page, perPage: perPage);
      return Right(posts);
    } on DioError catch (e) {
      return Left(ForbiddenFailure("Erro no consumo da API. - ${e.message}"));
    }
  }
}
