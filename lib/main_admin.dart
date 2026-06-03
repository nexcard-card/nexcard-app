import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'NexCard Admin',
      debugShowCheckedModeBanner: false,
      home: AdminHome(),
    );
  }
}

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late final WebViewController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF060608))
      ..enableZoom(false)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (_) => NavigationDecision.navigate,
      ))
      ..loadFlutterAsset('assets/admin.html');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060608),
      body: SafeArea(
        child: WebViewWidget(
          controller: _ctrl,
          gestureRecognizers: {
            Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer(),
            ),
            Factory<TapGestureRecognizer>(
              () => TapGestureRecognizer(),
            ),
            Factory<LongPressGestureRecognizer>(
              () => LongPressGestureRecognizer(),
            ),
          },
        ),
      ),
    );
  }
}