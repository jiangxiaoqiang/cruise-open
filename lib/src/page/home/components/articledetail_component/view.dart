import 'package:cruise/src/common/article_action.dart';
import 'package:cruise/src/common/helpers.dart';
import 'package:cruise/src/common/net/rest/http_result.dart';
import 'package:cruise/src/common/repo.dart';
import 'package:cruise/src/common/utils/common_utils.dart';
import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/models/api/fav_status.dart';
import 'package:cruise/src/models/api/upvote_status.dart';
import 'package:cruise/src/page/channel/channelpg_component/page.dart';
import 'package:cruise/src/page/home/components/articledetail_component/action.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/dom.dart' as dom;

import 'state.dart';

Widget buildView(ArticleDetailState state, Dispatch dispatch, ViewService viewService) {
  Item item = state.article;
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
      if (offsetDifference < 0) {
        if (PaintingBinding.instance != null && PaintingBinding.instance!.imageCache != null) {
          // https://mp.weixin.qq.com/s/yUm4UFggYLgDbj4_JCjEdg
          // https://musicfe.dev/flutter/
          PaintingBinding.instance!.imageCache!.clear();
          PaintingBinding.instance!.imageCache!.clearLiveImages();
        }
        Navigator.pop(context);
      }
    }
  }

  void touchUpvote(String action, UpvoteStatus upvoteStatus) async {
    HttpResult result = (await ArticleAction.upvote(articleId: item.id.toString(), action: action))!;

    if (result.result == Result.error) {
      Fluttertoast.showToast(
          msg: "点赞失败",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      if (upvoteStatus.statusCode == "upvote") {
        dispatch(ArticleDetailActionCreator.onVote(UpvoteStatus.UPVOTE));
      }
      if (upvoteStatus.statusCode == "unupvote" && item.upvoteCount > 0) {
        dispatch(ArticleDetailActionCreator.onVote(UpvoteStatus.UNUPVOTE));
      }
      Fluttertoast.showToast(
          msg: upvoteStatus.statusCode == "upvote" ? "点赞成功" : "取消点赞成功",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void touchFav(String action, FavStatus favStatus) async {
    HttpResult result = (await ArticleAction.fav(articleId: item.id.toString(), action: action))!;

    if (result.result == Result.error) {
      Fluttertoast.showToast(
          msg: favStatus.statusCode == "fav" ? "添加收藏失败" : "取消收藏失败",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      if (favStatus.statusCode == "fav") {
        dispatch(ArticleDetailActionCreator.onFav(FavStatus.FAV));
      }
      if (favStatus.statusCode == "unfav" && item.favCount > 0) {
        dispatch(ArticleDetailActionCreator.onFav(FavStatus.UNFAV));
      }
      Fluttertoast.showToast(
          msg: favStatus.statusCode == "fav" ? "添加收藏成功" : "取消收藏成功",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void navToChannelDetail() async {
    Channel channel = (await Repo.fetchChannelItem(int.parse(item.subSourceId)))!;
    var data = {'name': "originalstories", "channel": channel};
    Widget page = ChannelpgPage().buildPage(data);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// 是否是编辑选择频道链接显示不同的颜色
  TextStyle getDomainStyle(Item article) {
    if (article.editorPick == 1) {
      return new TextStyle(color: Color(0xFFFFA826), fontSize: 15);
    } else {
      return new TextStyle(color: Color(0xFF0A0A0A), fontSize: 15);
    }
  }

  ImageSourceMatcher base64UriMatcher() =>
      (attributes, element) => attributes["src"] != null && attributes["src"]!.startsWith("data:image") && attributes["src"]!.contains("base64,");
  

  Widget loadingWidget() {
    return Center(
      child: Container(
          height: 400.0,
          width: 120.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                height: 50.0,
                width: 50.0,
              )
            ],
          )),
    );
  }

  final Map<ImageSourceMatcher, ImageRender> defaultImageRenders = {
    base64UriMatcher(): base64ImageRender(),
    assetUriMatcher(): assetImageRender(),
    networkSourceMatcher(extension: "svg"): svgNetworkImageRender(),
    networkSourceMatcher(): networkImageRender( loadingWidget: loadingWidget),
  };

  SingleChildScrollView buildListView(Item item, BuildContext context) {
    return SingleChildScrollView(
        key: PageStorageKey("detail" + item.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () => CommonUtils.launchUrl(item.link),
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
            if (item.domain != "")
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                    onTap: () async {
                      navToChannelDetail();
                    },
                    child: Text(
                      item.domain,
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
                  customImageRenders: defaultImageRenders,
                  onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, dom.Element? element) {
                    CommonUtils.launchUrl(url);
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
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Feather.share_2,
                  ),
                  onPressed: () => handleShare(id: item.id, title: item.title, postUrl: item.link),
                ),
              ],
            ),
          ],
        ));
  }

  //var imageCache= PaintingBinding.instance!.imageCache;

  //print("dd:"+imageCache!.currentSizeBytes.toString());
  //print("size:" + imageCache.currentSize.toString());

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
          child: buildListView(item, context),
        ),
      ));
}
