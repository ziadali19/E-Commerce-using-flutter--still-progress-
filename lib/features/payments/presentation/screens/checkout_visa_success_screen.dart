import 'package:e_commerce/core/utilis/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../cart/controller/cubit/cart_cubit.dart';
import '../../../home/presentation/layouts/home_layout_screen.dart';

class CheckoutVisaSuccessScreen extends StatelessWidget {
  const CheckoutVisaSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
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
      ..loadRequest(Uri.parse(
          'https://accept.paymob.com/api/acceptance/iframes/723654?payment_token=${AppConstants.paymobFinalToken}'));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/homevisa.svg',
            color: AppConstants.primaryColor,
          ),
          onPressed: () {
            CartCubit.get(context).getUserCart(token!);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const HomeLayoutScreen(),
            ));
          },
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
