import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebChatScreen extends StatefulWidget {
  const WebChatScreen({super.key});

  @override
  State<WebChatScreen> createState() =>
      _WebChatScreenState();
}

class _WebChatScreenState
    extends State<WebChatScreen> {

  late final WebViewController controller;

  bool isLoading = true;

  @override
  void initState() {

    super.initState();

    controller = WebViewController()

      ..setJavaScriptMode(
        JavaScriptMode.unrestricted,
      )

      ..setNavigationDelegate(

        NavigationDelegate(

          onPageFinished: (url) {

            setState(() {
              isLoading = false;
            });
          },

          onWebResourceError: (error) {

            print(error.description);
          },
        ),
      )

      ..loadRequest(
        Uri.parse(
          'https://zed344-agri-expert.hf.space',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: Stack(

          children: [

            WebViewWidget(
              controller: controller,
            ),

            if (isLoading)

              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}