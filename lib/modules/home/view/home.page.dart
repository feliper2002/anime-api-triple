// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:tripleintoxianimeapi/modules/home/controllers/anime_controller.dart';
import 'package:tripleintoxianimeapi/modules/home/post_state.dart';

import 'widgets/post_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();

  bool get _isBottom {
    if (!controller.hasClients) return false;
    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  _onScroll() {
    if (_isBottom) Modular.get<AnimeController>().getPosts();
  }

  @override
  void initState() {
    super.initState();
    Modular.get<AnimeController>().getInitialPosts();
    controller.addListener(_onScroll);
    Modular.get<AnimeController>().observer(
      onState: (state) => print(state),
      onError: (error) => print(error),
      onLoading: (loading) => print(loading),
    );
  }

  @override
  void dispose() {
    controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Anime Posts - API'),
          backgroundColor: Colors.black),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: ScopedBuilder(
          store: Modular.get<AnimeController>(),
          onLoading: (_) => _loader(),
          onError: (_, e) => const Text('Erro'),
          onState: (context, state) {
            if (state is SuccessPostState) {
              return ListView.builder(
                controller: controller,
                itemCount: state.posts.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  final post = state.posts[index];
                  return PostContainer(
                    post: post,
                  );
                },
              );
            } else if (state is ErrorPostState) {
              return Text(state.message);
            }
            return _loader();
          },
        ),
      ),
    );
  }

  _loader() =>
      const Center(child: CircularProgressIndicator(color: Colors.black));
}
