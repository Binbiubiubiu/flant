import 'package:exmaple/components/sub_title.dart';
import 'package:exmaple/routes.dart';
import 'package:exmaple/style.dart';
import 'package:flutter/material.dart';

import 'components/route_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flant Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
        ),
        backgroundColor: Color(0xFFF7F8FE),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: "Flant"),
      routes: CompRouter.pathMap,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: PageTheme.padding,
          child: ListView(
            children: [
              buildTitle(),
              buildSubTitle(),
              ...renderList(CompRouter.routes)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, top: 45.0, bottom: 16.0),
      child: Row(
        children: [
          Image.network(
            "https://img.yzcdn.cn/vant/logo.png",
            width: 32.0,
            height: 32.0,
          ),
          SizedBox(width: 16.0),
          Text(
            "Flant",
            style: TextStyle(fontSize: 32.0),
          )
        ],
      ),
    );
  }

  Widget buildSubTitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        "轻量、可靠的移动端 Flutter 组件库",
        style: TextStyle(
          color: PageTheme.subTextColor,
        ),
      ),
    );
  }

  List<Widget> renderList(List<CompRoute> source) {
    List<Widget> result = [];

    source.forEach((group) {
      result.add(SubTitle(text: group.name));

      var children = group.children;
      for (var i = 0; i < children.length; i++) {
        var route = children.elementAt(i);
        result.add(RouteButton(
          text: route.name,
          onPressed: () {
            Navigator.of(context).pushNamed(
              route.path,
              arguments: {
                "title": route.name,
              },
            );
          },
        ));
        if (i != children.length - 1) {
          result.add(SizedBox(height: 20.0));
        }
      }
    });

    return result;
  }
}
