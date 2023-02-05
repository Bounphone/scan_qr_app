import 'package:flutter_blueprint/models/webview/webview_arg.dart';
import 'package:flutter_blueprint/packages.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  var isLoading = 0;
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  late PullToRefreshController pullToRefreshController;

  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as WebViewArg;
    final String url = args.url;
    final String accessToken = args.accessToken;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            InAppWebView(
              key: webViewKey,
              pullToRefreshController: pullToRefreshController,
              initialUrlRequest: URLRequest(
                url: Uri.parse(url),
                headers: {"Authorization": "Bearer $accessToken"},
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webViewController = controller;
                controller.addJavaScriptHandler(
                    handlerName: "openURLLauncher",
                    callback: (args) async {
                      var urlFromJS = args[0];
                      if (!await launchUrl(Uri.parse(urlFromJS.toString()))) {
                        throw 'Could not launch $urlFromJS';
                      }
                    });
              },
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    supportZoom: false,
                    useShouldOverrideUrlLoading: true,
                    mediaPlaybackRequiresUserGesture: false,
                  ),
                  android: AndroidInAppWebViewOptions(
                    useHybridComposition: true,
                  ),
                  ios: IOSInAppWebViewOptions(
                    allowsInlineMediaPlayback: true,
                  )),
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                if (progress == 100) {
                  pullToRefreshController.endRefreshing();
                }
                setState(() {
                  isLoading = progress;
                });
              },
            ),
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.r)),
                          elevation: 7,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.shade800,
                                borderRadius: BorderRadius.circular(25.r)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 5.h),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (Platform.isAndroid) {
                                        webViewController?.reload();
                                      } else if (Platform.isIOS) {
                                        webViewController?.loadUrl(
                                            urlRequest: URLRequest(
                                                url: await webViewController
                                                    ?.getUrl()));
                                      }
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.refresh,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 5.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            isLoading < 100
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(),
          ],
        ),
      ),
    );
  }
}
