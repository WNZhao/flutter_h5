
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String h5String = '''
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="utf-8">
    <title>通过URL向flutter传递参数</title>
</head>

<body>
    <div id="btn" style="font-size: 2.5em">Hi h5 file</div>
</body>

</html>
''';

/// 通过loadfile的试来加载h5文件
class FlutterH5FileJump extends StatefulWidget {
  const FlutterH5FileJump({super.key});

  @override
  State<FlutterH5FileJump> createState() => _FlutterH5FileJumpState();
}

class _FlutterH5FileJumpState extends State<FlutterH5FileJump> {
  late WebViewController controller;

  get _loadBtn => FilledButton(
      onPressed: () {
        _onLoadLocalFile(context);
      },
      child: const Text(
        '加载H5',
        style: TextStyle(color: Colors.white),
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

  void _onLoadLocalFile(BuildContext context) async {
    // 我这里没有本地文件，就先将字符串写入文件，然后加载
    final String path = await _prepareLocalFile();
    await controller.loadFile(path);
  }
  // 将h5字符串写入文件
  _prepareLocalFile() async {
    // 获取应用的文档目录
    final String dir = (await getTemporaryDirectory()).path;
    final String path = '$dir/index.html';
    final File file = File(<String>{path,'hi','index.html'}.join(Platform.pathSeparator));
    await file.create(recursive: true);
    await file.writeAsString(h5String);
    return file.path;
  }
}
