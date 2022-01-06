import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(title: Text(args['title']), backgroundColor: Colors.black),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HtmlWidget(args['content']),
            ],
          ),
        ),
      ),
    );
  }
}
