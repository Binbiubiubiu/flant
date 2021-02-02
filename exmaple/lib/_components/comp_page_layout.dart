import 'package:flutter/material.dart';

import '../_components/main.dart';

abstract class CompPageLayout extends StatelessWidget {
  dynamic renderPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildPageContent(),
    );
  }

  buildAppBar(context) {
    dynamic query = ModalRoute.of(context).settings.arguments;
    return AppBar(
      title: Text(query["title"]),
    );
  }

  buildPageContent() {
    dynamic content = renderPageContent();
    if (content is List) {
      return ListView(
        padding: PageTheme.padding,
        children: content,
      );
    }

    return Padding(
      padding: PageTheme.padding,
      child: content,
    );
  }
}
