import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPaystack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: 'https://checkout.paystack.com/8t7yc9d0gv3rwmw',
        javascriptMode: JavascriptMode.unrestricted,
        userAgent: 'Flutter;Webview',
        navigationDelegate: (navigation) {
          //Listen for callback URL

          if (navigation.url == "https://hello.pstk.xyz/callback") {
            //verifyTransaction(reference);
            Navigator.of(context).pop(); //close webview
          } else {
            //most likely an error.
            Navigator.of(context).pop();
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
