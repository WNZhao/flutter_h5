import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Flutter2JSByUrl extends StatefulWidget {

  const Flutter2JSByUrl({super.key});

  @override
  State<Flutter2JSByUrl> createState() => _Flutter2JSByUrlState();
}

class _Flutter2JSByUrlState extends State<Flutter2JSByUrl> {
  int progress = 0;
  late WebViewController controller;

  get _loadBtn => FilledButton(onPressed: (){
    // controller.loadUrl('https://www.baidu.com');
    controller.loadRequest(Uri.parse('https://www.geekailab.com/io/flutter-trip/Flutter2JSByUrl.html?name=geekailab'));
  }, child: Text('加载H5页面', style: TextStyle(color: Colors.blue)
  ));

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
          setState(() {
             this.progress = progress;
          });
        },
      ));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('flutter通过url向js传递数据'),
        actions: <Widget>[
          _loadBtn
        ],
      ),
      body: Stack(
        children:[
          WebViewWidget(controller: controller),
          Positioned(child: Text('加载进度: $progress'), bottom: 100, left: 100, height: 30,)
        ]
      ),
    );
  }
}
