import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripleintoxianimeapi/modules/home/models/anime_model.dart';

class PostContainer extends StatelessWidget {
  final AnimePost? post;
  const PostContainer({Key? key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/content', arguments: {
          'title': post!.title!,
          'content': post!.content!,
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(3, 3),
              blurRadius: .6,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post!.title!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    post!.author!,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            _divider(),
            Text(
              post!.description!.replaceAll("&#46;&#46;&#46;", ""),
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.network(
                  post!.imagePath!,
                  errorBuilder: (_, __, ___) {
                    return Container();
                  },
                  loadingBuilder: (_, __, ___) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  },
                ).image),
              ),
            ),
            _divider(),
            Text(
              DateFormat.yMMMMEEEEd()
                  .format(DateTime.parse(post!.publishedAt!)),
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  _divider() => const Divider(
        indent: 10,
        endIndent: 10,
        thickness: 1,
        height: 1,
        color: Colors.black,
      );
}
