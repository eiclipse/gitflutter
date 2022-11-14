import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:gitpractice01/providers/MainActivityProvider.dart';
import 'package:gitpractice01/ui/main/TabViewFactory.dart';
import 'package:provider/provider.dart';

import 'components/Guide.dart';
import 'dto/MessagesDTO.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => MainAcitivityProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter App Practice'),
      ),
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
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 5,
        vsync: this
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        controller: _tabController,
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
                          Tab(text: 'UI'),
                          Tab(text: 'PapagoAPI'),
                          Tab(text: 'DB_Insert'),
                          Tab(text: 'DB_List'),
                          Tab(text: 'Balance'),
                        ],
                      ),
                    )
                ),
                Expanded(child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    TabViewFactory.getUITabView(),
                    TabViewFactory.getPapagoTabView(context),
                    TabViewFactory.get_DBInsert_TabView(context),
                    TabViewFactory.get_DBList_TabView(context),
                    Guide.getBorderedWidget(Guide.getDummyListView())
                  ],
                )
                )
              ],
            )),
      ),
      floatingActionButton: FabCircularMenu(            // floating action 버튼만의 영역
        key: fabKey,
        fabOpenIcon: Icon(Icons.add,color: Colors.black),
        fabCloseIcon:Icon(Icons.close,color: Colors.black),
        fabColor: Colors.white.withAlpha(200),
        ringColor: Colors.black.withAlpha(50),
        ringDiameter: screenWidth*0.9,
        children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.wifi,color: Colors.white,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.credit_card,color: Colors.white)),
          IconButton(onPressed: (){
            fabKey.currentState?.close();
          }, icon: Icon(Icons.account_box_rounded,color: Colors.white)),
        ],
      ),
    );
  }
}
