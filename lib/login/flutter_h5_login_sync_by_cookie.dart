

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FlutterH5LoginCookie extends StatefulWidget {
  const FlutterH5LoginCookie({super.key});

  @override
  State<FlutterH5LoginCookie> createState() => _FlutterH5LoginCookieState();
}

class _FlutterH5LoginCookieState extends State<FlutterH5LoginCookie> {
  WebViewCookieManager cookieManager = WebViewCookieManager();
  late WebViewController controller;

  get _loadBtn => FilledButton(
      onPressed: (){
        controller.loadRequest(Uri.parse('https://www.geekailab.com/io/flutter-trip/Flutter2JSByUrl.html?name=geekailab'));
      },
      child: Text('加载H5页面', style: TextStyle(color: Colors.blue))
  );

  get _setCookieBtn => FilledButton(
      onPressed: (){
        _setCookie();
      },
      child: Text('设置cookie', style: TextStyle(color: Colors.blue))
  );

  get _clearCookieBtn => FilledButton(
      onPressed: (){
        _clearCookie();
      },
      child: Text('清除cookie', style: TextStyle(color: Colors.blue))
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      // 开启js执行
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          debugPrint('progress: $progress');
        },
      ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter通过url向js传递数据'),
        actions: <Widget>[
          _loadBtn,
          _setCookieBtn,
          _clearCookieBtn,
        ],
      ),
      body: Stack(
        children:[
          WebViewWidget(controller: controller),
        ]
      ),
    );
  }

  void _setCookie() async {
    await cookieManager.setCookie(
     const WebViewCookie(name: 'token', value: 'adsfasfdsafasfasfasf', domain: 'geekailab.com')
    );
    await cookieManager.setCookie(
      const   WebViewCookie(name: 'uid', value: 'userid:000001', domain: 'geekailab.com')
    );
    final Object obj = await controller.runJavaScriptReturningResult('document.cookie');
    debugPrint('cookie: ${obj.toString()}');
  }

  void _clearCookie() async {
    await cookieManager.clearCookies();
    final Object obj = await controller.runJavaScriptReturningResult('document.cookie');
    debugPrint('cookie: ${obj}, cookie已清除');
  }
}
