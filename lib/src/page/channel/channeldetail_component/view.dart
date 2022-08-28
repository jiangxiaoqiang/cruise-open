import 'package:cruise/src/common/channel_action.dart';
import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/models/api/sub_status.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:wheel/wheel.dart';

import '../../../common/repo.dart';
import 'action.dart';
import 'state.dart';

class AllowMultipleHorizontalDragGestureRecognizer extends HorizontalDragGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}

Widget buildView(ChannelDetailState state, Dispatch dispatch, ViewService viewService) {
  Channel item = state.channel;
  int isFav = state.isFav;
  BuildContext context = viewService.context;

  Offset? _initialSwipeOffset;
  Offset? _finalSwipeOffset;

  void _onHorizontalDragStart(DragStartDetails details) {
    _initialSwipeOffset = details.globalPosition;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _finalSwipeOffset = details.globalPosition;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_initialSwipeOffset != null) {
      final offsetDifference = _initialSwipeOffset!.dx - _finalSwipeOffset!.dx;
      /**
       * set the offsetDifference value less than 0
       * avoid mis touch the screen and return to back page unexpected
       * if mis touch frequency, just decrease the offsetDifference value
       */
      if (offsetDifference < -40) {
        Navigator.pop(context);
      }
    }
  }

  void touchSub(String channelId, SubStatus subStatus) async {
    HttpResult result = await ChannelAction.sub(channelId: channelId, subStatus: subStatus);

    if (result.result == Result.error) {
      ToastUtils.showToast("订阅失败");
    } else {
      if (Repo.itemsChannelCache.containsKey(channelId)) {
        Repo.itemsChannelCache.remove(channelId);
      }
      isFav = subStatus.statusCode == "sub" ? 1 : 0;
      item.isFav = isFav;
      ToastUtils.showToast(subStatus.statusCode == "sub" ? "订阅成功" : "取消订阅成功");
    }
    dispatch(ChannelDetailActionCreator.onSubscribe(item));
  }

  return RawGestureDetector(
      gestures: {
        AllowMultipleHorizontalDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<AllowMultipleHorizontalDragGestureRecognizer>(
          () => AllowMultipleHorizontalDragGestureRecognizer(),
          (AllowMultipleHorizontalDragGestureRecognizer instance) {
            instance.onStart = _onHorizontalDragStart;
            instance.onUpdate = _onHorizontalDragUpdate;
            instance.onEnd = _onHorizontalDragEnd;
          },
        )
      },
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(
            16.0,
          ),
          child: SizedBox(
            height: 500.0,
            child: CustomScrollView(slivers: <Widget>[
              SliverToBoxAdapter(
                  child: InkWell(
                onTap: () => {},
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    child: Text(
                      item.subName == "" ? "" : item.subName,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              )),
              if (item.isFav == 1)
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8.0, right: 1),
                  child: ButtonTheme(
                      minWidth: 50,
                      height: 40.0,
                      child: RaisedButton.icon(
                        color: Theme.of(context).primaryColor,
                        icon: Icon(
                          EvaIcons.checkmarkCircle,
                          size: 16,
                          color: Theme.of(context).canvasColor,
                        ),
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                        onPressed: () => touchSub(item.id.toString(), SubStatus.UNSUB),
                        label: Text("已订阅"),
                      )),
                )),
              if (item.isFav != 1)
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8.0, right: 1),
                  child: ButtonTheme(
                      minWidth: 50,
                      height: 40.0,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                        onPressed: () => touchSub(item.id.toString(), SubStatus.SUB),
                        child: Text("订阅"),
                      )),
                )),
              SliverToBoxAdapter(
                  child: InkWell(
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
              )),
              if (item.content != "")
                SliverToBoxAdapter(
                    child: Html(
                  data: item.content,
                  style: {
                    "body": Style(
                      fontSize: FontSize(19.0),
                    ),
                  },
                  //onLinkTap: (url) => CommonUtils.launchUrl(url),
                )),
              if (state.articleListState.articles.length > 0)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  sliver: viewService.buildComponent("articlelist"),
                )
              else
                SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()))
            ]),
          ),
        ),
      ));
}
