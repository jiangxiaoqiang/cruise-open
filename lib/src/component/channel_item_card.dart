import 'package:Cruise/src/common/channel_action.dart';
import 'package:Cruise/src/common/deeplink_handler.dart';
import 'package:Cruise/src/common/net/rest/http_result.dart';
import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/models/api/sub_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

    void touchSub(String channelId, SubStatus subStatus) async {
      HttpResult result = await ChannelAction.sub(
          channelId: channelId,
          subStatus: subStatus
      );

      if (result.result == Result.error) {
        Fluttertoast.showToast(
            msg: "订阅失败",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else {
        isFav.value = subStatus.statusCode=="sub"?1:0;
        counter.value.isFav = isFav.value;
        Fluttertoast.showToast(
            msg: subStatus.statusCode=="sub"?"订阅成功":"取消订阅成功",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }

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
                  Flexible(
                      child:Text(
                      counter.value.subName,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                  if(isFav.value == 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 8.0,right: 1),
                      child: ButtonTheme(
                          minWidth: 50,
                          height: 30.0,
                          child: RaisedButton.icon(
                            color: Theme.of(context).primaryColor,
                            icon: Icon(
                              Feather.check_circle,
                              size: 16,
                            ),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                            onPressed: () => touchSub(counter.value.id.toString(),SubStatus.UNSUB),
                            label: Text("已订阅"),
                          )
                      ),
                    )
                  ,
                  if(isFav.value != 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 8.0,right: 1),
                      child: ButtonTheme(
                          minWidth: 50,
                          height: 30.0,
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                            onPressed: () => touchSub(counter.value.id.toString(),SubStatus.SUB),
                            child: Text("订阅"),
                          )
                      ),
                    )
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child:Text(
                        counter.value.intro,
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
