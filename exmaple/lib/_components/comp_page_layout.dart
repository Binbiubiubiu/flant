import 'package:flutter/material.dart';

import '../_components/main.dart';

abstract class CompPageLayout extends StatelessWidget {
  dynamic renderPageContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(
        child: buildPageContent(context),
      ),
    );
  }

  buildAppBar(BuildContext context) {
    dynamic query = ModalRoute.of(context).settings.arguments;
    return AppBar(
      centerTitle: true,
      title: Text(query["title"]),
    );
  }

  buildPageContent(BuildContext context) {
    dynamic content = renderPageContent(context);
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
