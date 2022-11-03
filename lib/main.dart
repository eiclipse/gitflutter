import 'package:flutter/material.dart';
import 'package:gitpractice01/ui/main/TabViewFactory.dart';

import 'components/Guide.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter App Practice'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{


  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    var tabController = TabController(
        length: 5,
        vsync: this
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
            constraints: const BoxConstraints(minWidth: 250, minHeight: 400, maxWidth: 500),
            height:queryData.size.height,
            width: queryData.size.width,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(  // Tabbar Container
                    decoration: BoxDecoration(color: Colors.black),
                    height:45,
                    child: Container(
                      width: queryData.size.width,
                      child: TabBar(
                        physics: BouncingScrollPhysics(),
                        controller: tabController,
                        isScrollable: true, // Required
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey, // Other tabs color
                        labelPadding: EdgeInsets.symmetric(horizontal: 40), // Space between tabs
                        padding: EdgeInsets.only(top:15),
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(color: Colors.white, width: 2), // Indicator height
                          insets: EdgeInsets.symmetric(horizontal: 48), // Indicator width
                        ),
                        tabs: [
                          Tab(text: 'Total'),
                          Tab(text: 'Your'),
                          Tab(text: 'Current'),
                          Tab(text: 'Earnings'),
                          Tab(text: 'Balance'),
                        ],
                      ),
                    )
                ),
                Expanded(child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    Guide.getBorderedWidget(TabViewFactory.getTotalTabView()),
                    Guide.getBorderedWidget(TabViewFactory.getTextTabView("Page2")),
                    Guide.getBorderedWidget(TabViewFactory.getTextTabView("Page3")),
                    Guide.getBorderedWidget(TabViewFactory.getTextTabView("Page4")),
                    Guide.getBorderedWidget(Guide.getDummyListView())
                  ],
                )
                )
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black.withAlpha(10),
        onPressed: (){},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
