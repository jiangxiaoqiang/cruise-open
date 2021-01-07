import 'package:Cruise/src/common/channel_action.dart';
import 'package:Cruise/src/common/net/rest/http_result.dart';
import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/models/api/sub_status.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../profile.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(ChannelDetailState state, Dispatch dispatch, ViewService viewService) {
  Channel item = state.channel;
  int isFav = state.isFav;
  BuildContext context = viewService.context;

  void launchUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Offset _initialSwipeOffset;
  Offset _finalSwipeOffset;

  void _onHorizontalDragStart(DragStartDetails details) {
    _initialSwipeOffset = details.globalPosition;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _finalSwipeOffset = details.globalPosition;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_initialSwipeOffset != null) {
      final offsetDifference = _initialSwipeOffset.dx - _finalSwipeOffset.dx;
      if (offsetDifference < 0) {
        Navigator.pop(context);
      }
    }
  }

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
      isFav = subStatus.statusCode=="sub"?1:0;
      item.isFav = isFav;
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

  return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height*0.9,
        ),
        color: Theme
            .of(context)
            .scaffoldBackgroundColor,
        child:Padding(
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
                      item.subName == "" ? "Comment" : item.subName,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5
                          .copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              if(item.isFav == 1)
                Padding(
                  padding: const EdgeInsets.only(top: 8,bottom: 8.0,right: 1),
                  child: ButtonTheme(
                      minWidth: 50,
                      height: 30.0,
                      child: RaisedButton.icon(
                        color: Theme.of(context).primaryColor,
                        icon: Icon(Feather.check_circle,
                          size: 16,
                          color: Theme.of(context).canvasColor,
                        ),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0)),
                        onPressed: () => touchSub(item.id.toString(),SubStatus.UNSUB),
                        label: Text("已订阅"),
                      )
                  ),
                ),
              if(item.isFav != 1)
                Padding(
                  padding: const EdgeInsets.only(top: 8,bottom: 8.0,right: 1),
                  child: ButtonTheme(
                      minWidth: 50,
                      height: 30.0,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0)),
                        onPressed: () => touchSub(item.id.toString(),SubStatus.SUB),
                        child: Text("订阅"),
                      )
                  ),
                ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfilePage(username: item.author)),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: item.author,
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption
                            .copyWith(
                          color: Theme
                              .of(context)
                              .primaryColor,
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
                  onLinkTap: (url) => launchUrl(url),
                ),
              if (item.parts.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                ),
            ],
          ),
        ),
      ));
}