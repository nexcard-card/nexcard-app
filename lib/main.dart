import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'NexCard',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  InAppLocalhostServer? server;

  @override
  void initState() {
    super.initState();
    _startServer();
  }

  Future<void> _startServer() async {
    server = InAppLocalhostServer(documentRoot: 'assets');
    await server!.start();
    setState(() {});
  }

  @override
  void dispose() {
    server?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0d0d1a),
      body: SafeArea(
        child: server == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF0099aa),
                ),
              )
            : InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri('http://localhost:8080/index.html'),
                ),
                initialSettings: InAppWebViewSettings(
                  javaScriptEnabled: true,
                  mediaPlaybackRequiresUserGesture: false,
                ),
              ),
      ),
    );
  }
}