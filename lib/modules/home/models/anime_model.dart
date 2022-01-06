import 'dart:convert';

class AnimePost {
  String? title;
  String? description;
  String? content;
  String? publishedAt;
  String? author;
  String? imagePath;
  String? postURL;

  AnimePost({
    this.title,
    this.description,
    this.content,
    this.publishedAt,
    this.author,
    this.imagePath,
    this.postURL,
  });

  factory AnimePost.fromMap(Map<String, dynamic> map) {
    return AnimePost(
      title: map['title']['rendered'] ?? map['title']['rendered'],
      description: map['yoast_head_json']['og_description'] ??
          map['yoast_head_json']['og_description'],
      content: map['content']['rendered'] ?? map['content']['rendered'],
      publishedAt: map['yoast_head_json']['article_published_time'] ??
          map['yoast_head_json']['article_published_time'],
      author: map['yoast_head_json']['twitter_creator'] ??
          map['yoast_head_json']['twitter_creator'],
      imagePath: map['yoast_head_json']['og_image'][0]['url'] ??
          map['yoast_head_json']['og_image'][0]['url'],
      postURL:
          map['yoast_head_json']['og_url'] ?? map['yoast_head_json']['og_url'],
    );
  }

  factory AnimePost.fromJson(String source) =>
      AnimePost.fromMap(json.decode(source));
}
