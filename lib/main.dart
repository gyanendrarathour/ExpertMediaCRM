import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xpert Media CRM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController webViewController;
  var loadingPercent = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webViewController = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercent = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercent = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercent = 100;
          });
        },
      ))
      ..loadRequest(Uri.parse('https://xpertmediamarketing.com/xpertcrm/'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            WebViewWidget(controller: webViewController),
            loadingPercent < 100
                ? LinearProgressIndicator(
                    color: Colors.green,
                    value: loadingPercent / 100,
                  )
                : const SizedBox()
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
