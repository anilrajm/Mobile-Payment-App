import 'package:flutter/material.dart';
import 'package:recharge_app_mega/views/views.dart';

class ContactMegaPay extends StatefulWidget {
  const ContactMegaPay({super.key});

  @override
  State<ContactMegaPay> createState() => _ContactMegaPayState();
}

class _ContactMegaPayState extends State<ContactMegaPay> {
  WebViewController? controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},

          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(MegaBrand.contactMegaPayEndpoint));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        toolbarHeight: 68.072.h,
        title: const Text('Contact Us'),
        actions: [
          NavigationControls(controller: controller!),

        ],
      ),
      body:  WebViewWidget(controller: controller!),
    );
  }
}