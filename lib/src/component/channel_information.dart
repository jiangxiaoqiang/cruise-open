import 'package:cruise/src/common/channel_action.dart';
import 'package:cruise/src/common/style/global_style.dart';
import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/models/api/sub_status.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wheel/wheel.dart';

class ChannelInformation extends HookWidget {
  const ChannelInformation({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Channel item;

  void launchUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var counter = useState<Channel>(item);
    var isFav = useState(counter.value.isFav);

    Offset? _initialSwipeOffset;
    Offset? _finalSwipeOffset;

    void _onHorizontalDragStart(DragStartDetails details) {
      _initialSwipeOffset = details.globalPosition;
    }

    void _onHorizontalDragUpdate(DragUpdateDetails details) {
      _finalSwipeOffset = details.globalPosition;
    }

    void _onHorizontalDragEnd(DragEndDetails details) {
      final offsetDifference = _initialSwipeOffset!.dx - _finalSwipeOffset!.dx;
      if (offsetDifference < 0) {
        Navigator.pop(context);
      }
    }

    void touchSub(String channelId, SubStatus subStatus) async {
      HttpResult result = await ChannelAction.sub(channelId: channelId, subStatus: subStatus);

      if (result.result == Result.error) {
        ToastUtils.showToast("订阅失败");
      } else {
        isFav.value = subStatus.statusCode == "sub" ? 1 : 0;
        counter.value.isFav = isFav.value;
        ToastUtils.showToast(subStatus.statusCode == "sub" ? "订阅成功" : "取消订阅成功");
      }
    }

    return GestureDetector(
        onHorizontalDragStart: _onHorizontalDragStart,
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        onHorizontalDragEnd: _onHorizontalDragEnd,
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(
              16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () => {},
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      child: Text(
                        item.subName,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                ),
                if (item.isFav == 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8.0, right: 1),
                    child: ButtonTheme(
                        minWidth: 50,
                        height: 30.0,
                        child: ElevatedButton.icon(
                          style: GlobalStyle.getButtonStyle(context),
                          icon: Icon(
                            EvaIcons.checkmarkCircle,
                            size: 16,
                            color: Theme.of(context).canvasColor,
                          ),
                          onPressed: () => touchSub(counter.value.id.toString(), SubStatus.UNSUB),
                          label: Text("已订阅"),
                        )),
                  ),
                if (item.isFav != 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8.0, right: 1),
                    child: ButtonTheme(
                        minWidth: 50,
                        height: 30.0,
                        child: ElevatedButton(
                          style: GlobalStyle.getButtonStyle(context),
                          onPressed: () => touchSub(counter.value.id.toString(), SubStatus.SUB),
                          child: Text("订阅"),
                        )),
                  ),
                InkWell(
                  onTap: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage(username: item.author)),
                    );*/
                  },
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: item.author,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (item.content != "")
                  Html(
                    data: item.content,
                    style: {
                      "body": Style(
                        fontSize: FontSize(19.0),
                      ),
                    },
                    //onLinkTap: (url) => launchUrl(url),
                  ),
                if (item.parts!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                  ),
              ],
            ),
          ),
        ));
  }
}
