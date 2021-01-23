import 'package:exmaple/components/sub_title.dart';
import 'package:exmaple/pages/button_page.dart';
import 'package:flutter/material.dart';

import 'components/route_button.dart';
import 'style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: "Flant"),
      routes: {
        "/button": (context) => ButtonPage(),
      },
    );
  }
}

const basic = [
  {
    "title": "Button 按钮",
    "route": "/button",
  },
];

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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: PageTheme.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubTitle(text: "基础组件"),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return RouteButton(
                  text: basic[index]["title"],
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      basic[index]["route"],
                      arguments: {
                        "title": basic[index]["title"],
                      },
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20.0);
              },
              itemCount: basic.length,
            ),
          ],
        ),
      ),
    );
  }
}
