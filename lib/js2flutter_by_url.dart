import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String h5JS2FlutterByURL = '''
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>js向Flutter传递数据</title>
    <script type="text/javascript">
      function callFlutter() {
        // 通过url传递数据
        window.location.href = 'hi://webview?name=张三&age=18';
      }
    </script>
  </head>
  <body>
    <button onclick="callFlutter()">点击</button>
  </body>
</html>

''';

class JS2Flutter extends StatefulWidget {
  const JS2Flutter({super.key});

  @override
  State<JS2Flutter> createState() => _JS2FlutterState();
}

class _JS2FlutterState extends State<JS2Flutter> {
  late WebViewController controller;

  get _loadBtn => FilledButton(onPressed: (){
    controller.loadHtmlString(h5JS2FlutterByURL);
  }, child: Text('加载H5页面'));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      // 开启js执行
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
// 注入js代码
      ..setNavigationDelegate(
          NavigationDelegate(onNavigationRequest: (NavigationRequest request) {
        // 约定一个通信协议
        if (request.url.startsWith('hi://webview')) {
          debugPrint('JS2Flutter处理js通过url传递过来的数据: ${request}');
          Uri uri = Uri.parse(request.url);
          String name = uri.queryParameters['name'] ?? '';
          String age = uri.queryParameters['age'] ?? '';
          debugPrint('name: $name, age: $age');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('name: $name, age: $age'),
          ));
          return NavigationDecision.prevent; // 阻止页面跳转
        }
        debugPrint('非 hi://webview 开头的进行放行 ${request}');
        return NavigationDecision.navigate;
      }));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('通过js向Flutter传递数据'),
          actions: <Widget>[_loadBtn]
      ),
      body: WebViewWidget(controller: controller,)
    );
  }
}
