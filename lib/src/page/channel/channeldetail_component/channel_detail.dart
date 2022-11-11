import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:wheel/wheel.dart';

import '../../../common/channel_action.dart';
import '../../../models/Item.dart';
import '../../../models/api/sub_status.dart';
import '../../sub/subarticlelist_component/sub_article_list_controller.dart';
import '../channelarticlelist_component/channel_article_list.dart';
import '../channelarticlelist_component/channel_article_list_controller.dart';
import 'channel_detail_controller.dart';

class AllowMultipleHorizontalDragGestureRecognizer extends HorizontalDragGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}

class ChannelDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChannelDetailController>(
        init: ChannelDetailController(),
        builder: (controller) {
          int isFav = controller.isFav;
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
              isFav = subStatus.statusCode == "sub" ? 1 : 0;
              controller.updateChannelFav(isFav);
              ToastUtils.showToast(subStatus.statusCode == "sub" ? "订阅成功" : "取消订阅成功");
            }
            if (subStatus.statusCode != "sub") {
              final SubArticleListController articleListController = Get.put(SubArticleListController());
              articleListController.removeArticles(channelId);
            }
          }

          Widget navChannelArticleList(List<ArticleItem> articles) {
            final ChannelArticleListController subArticleListController = Get.put(ChannelArticleListController());
            subArticleListController.subArticles = articles;
            return new ChannelArticleList();
          }

          ButtonStyle textButtonStyle = ElevatedButton.styleFrom(
              onPrimary: Colors.black,
              foregroundColor: Theme.of(context).primaryColor,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)));

          return RawGestureDetector(
              gestures: {
                AllowMultipleHorizontalDragGestureRecognizer:
                    GestureRecognizerFactoryWithHandlers<AllowMultipleHorizontalDragGestureRecognizer>(
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
                              controller.channel.subName == "" ? "" : controller.channel.subName,
                              style: Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                      )),
                      if (controller.channel.isFav == 1)
                        SliverToBoxAdapter(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8.0, right: 1),
                          child: ButtonTheme(
                              minWidth: 50,
                              height: 40.0,
                              child: ElevatedButton.icon(
                                style: textButtonStyle,
                                icon: Icon(
                                  EvaIcons.checkmarkCircle,
                                  size: 16,
                                  color: Theme.of(context).canvasColor,
                                ),
                                onPressed: () => touchSub(controller.channel.id.toString(), SubStatus.UNSUB),
                                label: Text("已订阅"),
                              )),
                        )),
                      if (controller.channel.isFav != 1)
                        SliverToBoxAdapter(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8.0, right: 1),
                          child: ButtonTheme(
                              minWidth: 50,
                              height: 40.0,
                              child: ElevatedButton(
                                style: textButtonStyle,
                                onPressed: () => touchSub(controller.channel.id.toString(), SubStatus.SUB),
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
                                text: controller.channel.author,
                                style: Theme.of(context).textTheme.caption!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      )),
                      if (controller.channel.content != "")
                        SliverToBoxAdapter(
                            child: Html(
                          data: controller.channel.content,
                          style: {
                            "body": Style(
                              fontSize: FontSize(19.0),
                            ),
                          },
                          //onLinkTap: (url) => CommonUtils.launchUrl(url),
                        )),
                      if (controller.channelDetailArticles.length > 0)
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          sliver: navChannelArticleList(controller.channelDetailArticles),
                        )
                    ]),
                  ),
                ),
              ));
        });
  }
}
