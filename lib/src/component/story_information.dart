import 'package:Cruise/src/common/article_action.dart';
import 'package:Cruise/src/common/net/rest/http_result.dart';
import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/models/api/fav_status.dart';
import 'package:Cruise/src/models/api/upvote_status.dart';
import 'package:Cruise/src/page/channel_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:Cruise/src/component/part_snippet.dart';
import 'package:Cruise/src/common/helpers.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/common/Repo.dart';
import 'package:url_launcher/url_launcher.dart';

final partsProvider = FutureProvider.family((ref, int id) async {
  return await Repo.fetchArticleItem(id);
});

class StoryInformation extends HookWidget {
  const StoryInformation({Key key, @required this.item}) : super(key: key);

  final Item item;

  void launchUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var article = useState<Item>(item);

    final parts = item.parts.map((i) => useProvider(partsProvider(i))).toList();

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

    void touchUpvote(String action, UpvoteStatus upvoteStatus) async {
      HttpResult result = await ArticleAction.upvote(
          articleId: item.id.toString(), action: action);

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
        article.value.isUpvote = upvoteStatus.statusCode == "upvote" ? 1 : 0;
        if (upvoteStatus.statusCode == "upvote") {
          article.value.upvoteCount = article.value.upvoteCount + 1;
        }
        if (upvoteStatus.statusCode == "unupvote" &&
            article.value.upvoteCount > 0) {
          article.value.upvoteCount = article.value.upvoteCount - 1;
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
      HttpResult result = await ArticleAction.fav(
          articleId: item.id.toString(), action: action);

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
        article.value.isFav = favStatus.statusCode == "fav" ? 1 : 0;
        if (favStatus.statusCode == "fav") {
          article.value.favCount = article.value.favCount + 1;
        }
        if (favStatus.statusCode == "unfav" && article.value.favCount > 0) {
          article.value.favCount = article.value.favCount - 1;
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
                  onTap: () => launchUrl(item.link),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      child: Text(
                        item.title == "" ? "Comment" : item.title,
                        style: Theme.of(context).textTheme.headline5.copyWith(
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
                          Channel channel = await Repo.fetchChannelItem(
                              int.parse(item.subSourceId));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChannelPage(item: channel)),
                            //ProfilePage(username: item.author))
                          );
                        },
                        child: Text(
                          item.domain,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Theme.of(context).primaryColor),
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
                    onLinkTap: (url) => launchUrl(url),
                  ),
                if (item.parts.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: item.parts.length,
                      itemBuilder: (context, index) {
                        return PartSnippet(part: parts[index]);
                      },
                    ),
                  ),
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
                                  icon: Icon(Icons.bookmark,
                                      color: Theme.of(context).primaryColor),
                                  onPressed: () =>
                                      touchFav("unfav", FavStatus.UNFAV),
                                ),
                              if (item.isFav != 1)
                                IconButton(
                                  icon: Icon(Icons.bookmark),
                                  onPressed: () =>
                                      touchFav("fav", FavStatus.FAV),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Text(
                                  "${article.value.favCount}",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
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
                              if (article.value.isUpvote == 1)
                                IconButton(
                                  icon: Icon(Icons.thumb_up,
                                      color: Theme.of(context).primaryColor),
                                  onPressed: () => touchUpvote(
                                      "unupvote", UpvoteStatus.UNUPVOTE),
                                ),
                              if (article.value.isUpvote != 1)
                                IconButton(
                                  icon: Icon(Icons.thumb_up),
                                  onPressed: () => touchUpvote(
                                      "upvote", UpvoteStatus.UPVOTE),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "${article.value.upvoteCount}",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
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
                      onPressed: () => handleShare(
                          id: item.id, title: item.title, postUrl: item.link),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
