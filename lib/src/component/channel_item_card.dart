import 'dart:convert';
import 'dart:typed_data';

import 'package:cruise/src/common/channel_action.dart';
import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/models/api/sub_status.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wheel/wheel.dart';

class ChannelItemCard extends HookWidget {
  const ChannelItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Channel item;

  @override
  Widget build(BuildContext context) {
    var counter = useState<Channel>(item);
    var isFav = useState(counter.value.isFav);
    double screenWidth = MediaQuery.of(context).size.width;

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

    final Image defaultImage = Image.asset('images/Icon-App-83.5x83.5@3x.png');
    /* var foregroundImage = counter.value.favIconUrl == "" ? defaultImage : Image.network(
        global.staticResourceUrl + "/" + counter.value.localIconUrl,
      loadingBuilder: (context,child,loadingProgress)=>(loadingProgress == null) ? child : CircularProgressIndicator(),
      errorBuilder: (context, error, stackTrace) => defaultImage,
    );*/
    var foregroundImage;
    if (counter.value.iconData != null && counter.value.iconData != "") {
      Uint8List base64Decode(String source) => base64.decode(source);
      Uint8List uint8list = base64Decode(counter.value.iconData);
      foregroundImage = Image.memory(uint8list);
    } else {
      foregroundImage = defaultImage;
    }

    ButtonStyle textButtonStyle = ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).primaryColor, shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)));

    ButtonStyle textButtonStyleColor = ElevatedButton.styleFrom(foregroundColor: Theme.of(context).primaryColor);

    return Card(
      key: Key(counter.value.id.toString()),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                    foregroundImage: foregroundImage.image,
                  ),
                  SizedBox(
                    width: screenWidth - 230,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(counter.value.subName,
                          softWrap: true,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                  if (isFav.value == 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8.0, left: 10),
                      child: ButtonTheme(
                          minWidth: 100,
                          height: 40.0,
                          child: ElevatedButton.icon(
                            style: textButtonStyleColor,
                            icon: Icon(
                              EvaIcons.checkmarkCircle,
                              size: 16,
                            ),
                            onPressed: () => touchSub(counter.value.id.toString(), SubStatus.UNSUB),
                            label: Text("已订阅"),
                          )),
                    ),
                  if (isFav.value != 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8.0, right: 1),
                      child: ButtonTheme(
                          minWidth: 100,
                          height: 40.0,
                          child: ElevatedButton(
                            style: textButtonStyle,
                            onPressed: () => touchSub(counter.value.id.toString(), SubStatus.SUB),
                            child: Text("订阅"),
                          )),
                    )
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(counter.value.intro,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 15,
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
