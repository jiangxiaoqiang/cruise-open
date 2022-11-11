import 'package:cruise/src/page/channel/channelpg_component/channel_pg_controller.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' as dom;
import 'package:wheel/wheel.dart';

import '../../../../common/article_action.dart';
import '../../../../common/helpers.dart';
import '../../../../common/nav/nav_util.dart';
import '../../../../common/utils/cruise_common_utils.dart';
import '../../../../models/Item.dart';
import '../../../../models/api/fav_status.dart';
import '../../../../models/api/upvote_status.dart';
import '../../../channel/channelpg_component/channel_pg.dart';
import '../../../sub/subarticlelist_component/sub_article_list_controller.dart';
import 'article_detail_controller.dart';

class ArticleDetail extends StatelessWidget {
  final ArticleDetailController articleDetailController = Get.put(ArticleDetailController());

  Offset? _initialSwipeOffset;
  Offset? _finalSwipeOffset;

  void _onHorizontalDragStart(DragStartDetails details) {
    _initialSwipeOffset = details.globalPosition;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _finalSwipeOffset = details.globalPosition;
  }

  /// 是否是编辑选择频道链接显示不同的颜色
  TextStyle getDomainStyle(ArticleItem article) {
    if (article.editorPick == 1) {
      return new TextStyle(color: Color(0xFFFFA826), fontSize: 15);
    } else {
      return new TextStyle(color: Color(0xFF0A0A0A), fontSize: 15);
    }
  }

  @override
  Widget build(BuildContext context) {
    ArticleItem item = articleDetailController.article;

    void _onHorizontalDragEnd(DragEndDetails details) {
      if (_initialSwipeOffset != null) {
        final offsetDifference = _initialSwipeOffset!.dx - _finalSwipeOffset!.dx;
        if (offsetDifference < 0) {
          if (PaintingBinding.instance != null && PaintingBinding.instance.imageCache != null) {
            // https://mp.weixin.qq.com/s/yUm4UFggYLgDbj4_JCjEdg
            // https://musicfe.dev/flutter/
            PaintingBinding.instance.imageCache.clear();
            PaintingBinding.instance.imageCache.clearLiveImages();
          }
          articleDetailController.article = new ArticleItem();
          Navigator.pop(context);
        }
      }
    }

    void navToChannelDetail() async {
      if (int.parse(item.subSourceId) > 0) {
        final ChannelPgController articlePgController = Get.put(ChannelPgController());
        articlePgController.channelId.value = item.subSourceId;
        Get.to(ChannelPg());
      } else {
        ToastUtils.showToast("channel id less than 0");
      }
    }

    void popDialog(String tips) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("提示"),
              content: Text(tips),
              actions: <Widget>[
                TextButton(
                  child: Text("暂不"),
                  onPressed: () => {Navigator.of(context).pop()}, //关闭对话框
                ),
                TextButton(
                  child: Text("去登陆"),
                  onPressed: () {
                    // ... 执行删除操作
                    NavUtil.navLogin(context);
                    // Navigator.of(context).pop(true); //关闭对话框
                  },
                ),
              ],
            );
            ;
          });
    }

    void touchUpvote(String action, UpvoteStatus upvoteStatus) async {
      bool isLoggedIn = await Auth.isLoggedIn();
      if (!isLoggedIn) {
        popDialog("登录后可操作，确定去登陆吗?");
      } else {
        articleDetailController.handleVoteImpl(upvoteStatus, action, item);
      }
    }

    void touchFav(String action, FavStatus favStatus) async {
      bool isLoggedIn = await Auth.isLoggedIn();
      if (!isLoggedIn) {
        popDialog("登录后可收藏，确定去登陆吗?");
      }
      HttpResult result = (await ArticleAction.fav(articleId: item.id.toString(), action: action))!;
      if (result.result == Result.error) {
        ToastUtils.showToast(favStatus.statusCode == "fav" ? "添加收藏失败" : "取消收藏失败");
      } else {
        articleDetailController.handleFavImpl(favStatus, action, item);
        final SubArticleListController articleListController = Get.put(SubArticleListController());
        articleListController.removeArticlesById(item.id.toString());
      }
    }

    SingleChildScrollView buildListView(ArticleItem item, BuildContext context) {
      return SingleChildScrollView(
          key: PageStorageKey<String>("article-detail-" + item.id),
          controller: new ScrollController(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () => CruiseCommonUtils.launchUrl(item.link),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    child: Text(
                      item.title,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                    onTap: () async {
                      navToChannelDetail();
                    },
                    child: Text(
                      item.domain.isEmpty ? "--" : item.domain,
                      style: getDomainStyle(item),
                    )),
              ),
              InkWell(
                onTap: () {},
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: item.author,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      TextSpan(
                        text: " ${String.fromCharCode(8226)} ",
                        style: Theme.of(context).textTheme.caption,
                      ),
                      TextSpan(
                        text: item.ago,
                        style: Theme.of(context).textTheme.caption,
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
                    onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, dom.Element? element) {
                      CruiseCommonUtils.launchUrl(url);
                    }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          children: [
                            if (item.isFav == 1)
                              IconButton(
                                icon: Icon(Icons.bookmark, color: Theme.of(context).primaryColor),
                                onPressed: () => touchFav("unfav", FavStatus.UNFAV),
                              ),
                            if (item.isFav != 1)
                              IconButton(
                                icon: Icon(Icons.bookmark),
                                onPressed: () => touchFav("fav", FavStatus.FAV),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0),
                              child: Text(
                                "${item.favCount}",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.caption!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: Row(
                          children: [
                            if (item.isUpvote == 1)
                              IconButton(
                                icon: Icon(Icons.thumb_up, color: Theme.of(context).primaryColor),
                                onPressed: () => touchUpvote("unupvote", UpvoteStatus.UNUPVOTE),
                              ),
                            if (item.isUpvote != 1)
                              IconButton(
                                icon: Icon(Icons.thumb_up),
                                onPressed: () => touchUpvote("upvote", UpvoteStatus.UPVOTE),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "${item.upvoteCount}",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.caption!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ),
                            if (item.isUpvote == -1)
                              IconButton(
                                icon: Icon(Icons.thumb_down, color: Theme.of(context).primaryColor),
                                onPressed: () => touchUpvote("undownvote", UpvoteStatus.UNDOWNVOTE),
                              ),
                            if (item.isUpvote != -1)
                              IconButton(
                                icon: Icon(Icons.thumb_down),
                                onPressed: () => touchUpvote("downvote", UpvoteStatus.DOWNVOTE),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      EvaIcons.share,
                    ),
                    onPressed: () => handleShare(id: item.id, title: item.title, postUrl: item.link, context: context),
                  ),
                ],
              ),
            ],
          ));
    }

    return GetBuilder<ArticleDetailController>(
        init: ArticleDetailController(),
        builder: (controller) {
          if (int.parse(controller.article.subSourceId) <= 0) {
            return Center(child: CircularProgressIndicator());
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
                  padding: const EdgeInsets.all(16.0),
                  child: buildListView(controller.article, context),
                ),
              ));
        });
  }
}
