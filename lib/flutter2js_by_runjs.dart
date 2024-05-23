import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String h5Flutter2JSByrunJavaScript = '''
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="utf-8">
    <title>Flutter向H5传递数据-通过runJavaScript</title>
    <script type="text/javascript">
        function hiCallJs(msg) {
            document.getElementById('resultTxt').innerHTML = 'Flutter传递过来的数据：' + msg;
        }
        function hiCallJsWithResult(v1, v2) {
            return parseInt(v1) + parseInt(v2);
        }
    </script>
</head>

<body>
    <div id="resultTxt" style="font-size: 2.5em">这里展示Flutter传递过来的数据</button>
</body>

</html>
''';

class Flutter2JSByRunJavascript extends StatefulWidget {
  const Flutter2JSByRunJavascript({super.key});

  @override
  State<Flutter2JSByRunJavascript> createState() => _Flutter2JSByRunJavascriptState();
}

class _Flutter2JSByRunJavascriptState extends State<Flutter2JSByRunJavascript> {
  late WebViewController controller;

  get _loadBtn => FilledButton(onPressed: (){
    controller.loadHtmlString(h5Flutter2JSByrunJavaScript);
  }, child: Text('加载H5页面', style: TextStyle(color: Colors.blue)
  ));

  get _fireDataBtn => FilledButton(onPressed: () async{
    var name = 'geekailab_flutter';
    controller.runJavaScript("hiCallJs('$name')"); // 传递参数带的是单引号
    var result = await controller.runJavaScriptReturningResult("hiCallJsWithResult(1, 2)");
    debugPrint('来自js的计算结果 result: $result');
  }, child: Text('发送数据', style: TextStyle(color: Colors.blue)
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
        title: const Text('flutter通过runJavascript向js传递数据'),
        actions: [_loadBtn,_fireDataBtn],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
        ],
      ),
    );
  }
}
