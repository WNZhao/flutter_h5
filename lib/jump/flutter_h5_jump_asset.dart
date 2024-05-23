import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FlutterH5AssetJump extends StatefulWidget {
  const FlutterH5AssetJump({super.key});

  @override
  State<FlutterH5AssetJump> createState() => _FlutterH5AssetJumpState();
}

class _FlutterH5AssetJumpState extends State<FlutterH5AssetJump> {
  late WebViewController controller;

  get _loadBtn => FilledButton(onPressed: (){
    // controller.loadUrl('https://www.baidu.com');
    _onLoadFlutterAssets(context);
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
        },
      ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter通过url向js传递数据'),
        actions: <Widget>[
          _loadBtn
        ],
      ),
      body: Stack(
        children:[
          WebViewWidget(controller: controller),
        ]
      ),
    );
  }

  void _onLoadFlutterAssets(BuildContext context) async {
    // 加载项目assets/hiH5/目录下的index.html文件
    // 注意：这里的路径是相对于pubspec.yaml文件的 assets: - assets/hiH5/ 配置的路径 里面的内容有增删要停止项目，pub get 后重新红地毯
    // 这个资源会跟着apk一起打包，不会被网络请求拦截
    await controller.loadFlutterAsset('assets/hiH5/index.html');
  }
}
