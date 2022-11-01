import 'package:flutter/material.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
            decoration: BoxDecoration(border: Border.all(width: 1,color:Colors.black)),
            constraints: const BoxConstraints(minWidth: 250, minHeight: 400),
            height:queryData.size.height,
            width: queryData.size.width,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  height:60,
                  child: Container(),
                ),
                Expanded(child: Guide.getBorderedWidget(ListView(
                  children: [
                    ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),),
                    ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),),
                    ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),),
                    ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),),
                    ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),),
                    ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),),
                    ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),),
                    ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),),
                    ListTile(title: Text("ABC" , style: TextStyle(fontSize: 24.0),),),

                  ],
                )))
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
