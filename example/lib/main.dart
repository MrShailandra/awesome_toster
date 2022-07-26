import 'package:awesome_toster/awesome_toster.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Awesome Toster'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Press Action Button For Warning Popup',
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: () {
                AwesomeToster().showOverlay(
                    context: context,
                    msg: "This is Warning Msg",
                    tosterHeight: 50,
                    prefixIcon: Icons.abc,
                    msgType: MsgType.WARNING);
              },
              tooltip: 'Warning',
              child: const Icon(Icons.warning),
            ),
            FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                AwesomeToster().showOverlay(
                    context: context,
                    msg: "This is Error Msg",
                    tosterHeight: 50,
                    prefixIcon: Icons.abc,
                    msgType: MsgType.ERROR);
              },
              tooltip: 'Error',
              child: const Icon(Icons.error),
            ),
            FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {
                AwesomeToster().showOverlay(
                    context: context,
                    msg: "This is Sucess Msg",
                    tosterHeight: 50,
                    msgType: MsgType.SUCESS);
              },
              tooltip: 'Sucess',
              child: const Icon(
                Icons.check,
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
