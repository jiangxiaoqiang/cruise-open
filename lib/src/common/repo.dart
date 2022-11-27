import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:cruise/src/common/cruise_user.dart';
import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:cruise/src/models/request/article/article_request.dart';
import 'package:http/http.dart' as http;
import 'package:wheel/wheel.dart' show AppLogHandler, GlobalConfig, RestApiError, RestClient;

import '../models/request/channel/channel_request.dart';

class Repo {
  static final articlesCache = <int, ArticleItem>{};
  static final channelsCache = <String, List<Channel>>{};
  static final _usersCache = <String, CruiseUser>{};
  final baseUrl = GlobalConfig.getBaseUrl();

  static Future<List<ArticleItem>> getArticles(ArticleRequest request) async {
    List<ArticleItem> articles = await _getArticles(request);
    return articles;
  }

  static Future<List<Channel>> getChannels(ChannelRequest request) async {
    String requestJson = request.toJson();
    if (channelsCache.containsKey(requestJson)) {
      return channelsCache[requestJson]!;
    }
    List<Channel> channels = await _getChannels(request);
    channelsCache.putIfAbsent(requestJson, () => channels);
    return channels;
  }

  static Future<List<String>> getCommentsIds({required ArticleItem item}) async {
    Stream<ArticleItem> stream = lazyFetchComments(item: item, assignDepth: false);
    List<String> comments = [];
    await for (ArticleItem comment in stream) {
      comments.add(comment.id);
    }
    return comments;
  }

  static Stream<ArticleItem> lazyFetchComments({required ArticleItem item, int depth = 0, bool assignDepth = true}) async* {
    if (item.kids!.isEmpty) return;
    for (int kidId in item.kids!) {
      ArticleItem kid = (await fetchArticleItem(kidId))!;
      if (assignDepth) kid.depth = depth;
      yield kid;
    }
  }

  static Future<List<ArticleItem>> prefetchComments({required ArticleItem item}) async {
    List<ArticleItem> result = [];
    if (item.parent != null) result.add(item);
    if (item.kids!.isEmpty) return Future.value(result);
    await Future.wait(item.kids!.map((kidId) async {
      ArticleItem kid = (await fetchArticleItem(kidId))!;
      await prefetchComments(item: kid);
    }));
    return Future.value(result);
  }

  static Future<List<ArticleItem?>> fetchByIds(List<int> ids) async {
    return Future.wait(ids.map((itemId) {
      return fetchArticleItem(itemId);
    }));
  }

  static Future<List<Channel>> _getChannels(ChannelRequest articleRequest) async {
    final typeQuery = _getStoryTypeQuery(StoriesType.channels);
    Map jsonMap = articleRequest.toMap();
    final response = await RestClient.postHttp("$typeQuery", jsonMap);
    if (RestClient.respSuccess(response)) {
      Map result = response.data["result"];
      if (result == null) {
        return List.empty();
      }
      List channels = result["list"];
      List<Channel> items = List.empty(growable: true);
      channels.forEach((element) {
        if (element != null) {
          HashMap<String, Object?> map = HashMap.from(element);
          Channel item = Channel.fromMap(map);
          items.add(item);
        } else {
          print("null channel");
        }
      });
      return items;
    }
    return List.empty();
  }

  static Future<List<ArticleItem>> _getArticles(ArticleRequest articleRequest) async {
    final typeQuery = _getStoryTypeQuery(articleRequest.storiesType);
    Map<String, dynamic>? jsonMap = articleRequest.toMap();
    final response = await RestClient.get("$typeQuery", queryParameters: jsonMap);
    if (RestClient.respSuccess(response)) {
      Map result = response.data["result"];
      List articles = result["list"];
      List<ArticleItem> items = List.empty(growable: true);
      articles.forEach((element) {
        if (element != null) {
          HashMap<String, Object> map = HashMap.from(element);
          ArticleItem item = ArticleItem.fromMap(map);
          items.add(item);
        } else {
          print("null article");
        }
      });
      return items;
    }
    return List.empty();
  }

  static Future<ArticleItem> fetchArticleDetail(int id) async {
    if (articlesCache.containsKey(id)) {
      return articlesCache[id]!;
    }
    final response = await RestClient.getHttp("/post/article/detail?id=" + id.toString());
    if (RestClient.respSuccess(response)) {
      Map articleResult = response.data["result"];
      String articleJson = JsonEncoder().convert(articleResult);
      ArticleItem parseItem = ArticleItem.fromJson(articleJson);
      articlesCache.putIfAbsent(id, () => parseItem);
      return parseItem;
    } else {
      AppLogHandler.logError(RestApiError('Item $id failed to fetch.'), JsonEncoder().convert(response));
    }
    return Future.value(new ArticleItem());
  }

  static Future<ArticleItem?> fetchArticleItem(int id) async {
    if (articlesCache.containsKey(id)) {
      return articlesCache[id];
    } else {
      final response = await RestClient.getHttp("/post/article?id=" + id.toString());
      if (RestClient.respSuccess(response)) {
        Map articleResult = response.data["result"];
        String articleJson = JsonEncoder().convert(articleResult);
        ArticleItem parseItem = ArticleItem.fromJson(articleJson);
        articlesCache[id] = parseItem;
      } else {
        AppLogHandler.logError(RestApiError('Item $id failed to fetch.'), JsonEncoder().convert(response));
      }
      return articlesCache[id];
    }
  }

  static Future<Channel?> fetchChannelItem(int id) async {
    if (id <= 0) {
      return null;
    }
    final response = await RestClient.getHttp("/post/sub/source/detail/$id");
    if (RestClient.respSuccess(response)) {
      Map channelResult = response.data["result"];
      String jsonContent = JsonEncoder().convert(channelResult);
      Channel parseItem = Channel.fromJson(jsonContent);
      List<dynamic> it = channelResult["articleDTOList"];
      List<ArticleItem> items = List.empty(growable: true);
      it.forEach((element) {
        ArticleItem localItem = ArticleItem.fromMap(element);
        items.add(localItem);
      });
      parseItem.articleDTOList = items;
      return parseItem;
    } else {
      AppLogHandler.logError(RestApiError('Item $id failed to fetch.'), JsonEncoder().convert(response));
    }
    return null;
  }

  static Future<CruiseUser?> fetchUser(String id) async {
    if (_usersCache.containsKey(id)) {
      return _usersCache[id];
    } else {
      String url = GlobalConfig.getBaseUrl() + "/user/$id.json";
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        if (response.body == "null") return null;
        _usersCache[id] = CruiseUser.fromJson(response.body);
      } else {
        AppLogHandler.logError(RestApiError('User $id failed to fetch.'), JsonEncoder().convert(response));
      }
    }
    return _usersCache[id];
  }

  static String _getStoryTypeQuery(StoriesType type) {
    switch (type) {
      case StoriesType.channels:
        return "/post/sub/source/page/cache";
      case StoriesType.subStories:
        return "/post/article/substories";
      case StoriesType.topStories:
        return "/post/article/newstories";
      case StoriesType.showStories:
        return "/post/article/newstories";
      case StoriesType.jobStories:
        return "/post/article/newstories";
      case StoriesType.favStories:
        return "/post/user/fav/article";
      case StoriesType.historyStories:
        return "/post/user/history/article";
      case StoriesType.originalStories:
        return "/post/article/originalstories";
      case StoriesType.channelStories:
        return "/post/article/channelstories";
      default:
        return "/post/article/newstories";
    }
  }
}
