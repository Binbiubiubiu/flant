import 'package:flutter/material.dart';

import './_components/main.dart';
import './_routes/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flant',
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
        child: ListView(
          padding: const EdgeInsets.only(
            top: 0.0,
            left: 20.0,
            right: 20.0,
            bottom: 20.0,
          ),
          children: [
            const _FlantAppTitle(),
            const _FlantAppSubTitle(),
            ...renderList(CompRouter.routes)
          ],
        ),
      ),
    );
  }

  List<Widget> renderList(List<CompRoute> source) {
    List<Widget> result = [];

    source.forEach((group) {
      result.add(
        SubTitle(
          text: group.title,
          padding: const EdgeInsets.only(top: 24.0, bottom: 16.0, left: 18.0),
        ),
      );

      var children = group.routes;
      for (var i = 0; i < children.length; i++) {
        var route = children.elementAt(i);
        result.add(RouteButton(
          text: [route.name, route.title].join(" "),
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

class _FlantAppTitle extends StatelessWidget {
  const _FlantAppTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class _FlantAppSubTitle extends StatelessWidget {
  const _FlantAppSubTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        "轻量、可靠的移动端 Flutter 组件库",
        style: TextStyle(
          color: Color.fromRGBO(69, 90, 100, 0.6),
        ),
      ),
    );
  }
}
