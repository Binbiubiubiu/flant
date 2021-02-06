import 'package:flutter/material.dart';

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
    dynamic query =
        ModalRoute.of(context).settings.arguments ?? {"title": "目标页面"};
    return AppBar(
      centerTitle: true,
      title: Text(query["title"]),
    );
  }

  buildPageContent(BuildContext context) {
    final pPagePadding = const EdgeInsets.only(
      top: 0.0,
      bottom: 20.0,
    );
    dynamic content = renderPageContent(context);
    if (content is List) {
      return ListView(
        padding: pPagePadding,
        children: content,
      );
    }

    return Padding(
      padding: pPagePadding,
      child: content,
    );
  }
}
