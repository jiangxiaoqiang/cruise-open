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

class Repo {
  static final _itemsCache = <int, Item>{};
  static final _usersCache = <String, CruiseUser>{};
  final baseUrl = GlobalConfig.getBaseUrl();

  static Future<List<Item>> getArticles(ArticleRequest request) async {
    List<Item> articles = await _getArticles(request);
    return articles;
  }

  static Future<List<Channel>> getChannels(ArticleRequest request) async {
    List<Channel> channels = await _getChannels(request);
    return channels;
  }

  static Future<List<String>> getCommentsIds({required Item item}) async {
    Stream<Item> stream = lazyFetchComments(item: item, assignDepth: false);
    List<String> comments = [];
    await for (Item comment in stream) {
      comments.add(comment.id);
    }
    return comments;
  }

  static Stream<Item> lazyFetchComments({required Item item, int depth = 0, bool assignDepth = true}) async* {
    if (item.kids!.isEmpty) return;
    for (int kidId in item.kids!) {
      Item kid = (await fetchArticleItem(kidId))!;
      if (assignDepth) kid.depth = depth;
      yield kid;
    }
  }

  static Future<List<Item>> prefetchComments({required Item item}) async {
    List<Item> result = [];
    if (item.parent != null) result.add(item);
    if (item.kids!.isEmpty) return Future.value(result);

    await Future.wait(item.kids!.map((kidId) async {
      Item kid = (await fetchArticleItem(kidId))!;
      await prefetchComments(item: kid);
    }));
    return Future.value(result);
  }

  static Future<List<Item?>> fetchByIds(List<int> ids) async {
    return Future.wait(ids.map((itemId) {
      return fetchArticleItem(itemId);
    }));
  }

  static Future<List<Channel>> _getChannels(ArticleRequest articleRequest) async {
    final typeQuery = _getStoryTypeQuery(articleRequest.storiesType);
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
          HashMap<String, Object> map = HashMap.from(element);
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

  static Future<List<Item>> _getArticles(ArticleRequest articleRequest) async {
    final typeQuery = _getStoryTypeQuery(articleRequest.storiesType);
    Map<String, dynamic>? jsonMap = articleRequest.toMap();
    final response = await RestClient.get("$typeQuery", queryParameters: jsonMap);
    if (RestClient.respSuccess(response)) {
      Map result = response.data["result"];
      List articles = result["list"];
      List<Item> items = List.empty(growable: true);
      articles.forEach((element) {
        if (element != null) {
          HashMap<String, Object> map = HashMap.from(element);
          Item item = Item.fromMap(map);
          items.add(item);
        } else {
          print("null article");
        }
      });
      return items;
    }
    return List.empty();
  }

  static Future<Item?> fetchArticleDetail(int id) async {
    if (_itemsCache.containsKey(id)) {
      return _itemsCache[id];
    }
    final response = await RestClient.getHttp("/post/article/detail?id=" + id.toString());
    if (RestClient.respSuccess(response)) {
      Map articleResult = response.data["result"];
      String articleJson = JsonEncoder().convert(articleResult);
      Item parseItem = Item.fromJson(articleJson);
      _itemsCache.putIfAbsent(id, () => parseItem);
      return parseItem;
    } else {
      AppLogHandler.logError(RestApiError('Item $id failed to fetch.'), JsonEncoder().convert(response));
    }
    return null;
  }

  static Future<Item?> fetchArticleItem(int id) async {
    if (_itemsCache.containsKey(id)) {
      return _itemsCache[id];
    } else {
      final response = await RestClient.getHttp("/post/article?id=" + id.toString());
      if (RestClient.respSuccess(response)) {
        Map articleResult = response.data["result"];
        String articleJson = JsonEncoder().convert(articleResult);
        Item parseItem = Item.fromJson(articleJson);
        _itemsCache[id] = parseItem;
      } else {
        AppLogHandler.logError(RestApiError('Item $id failed to fetch.'), JsonEncoder().convert(response));
      }
      return _itemsCache[id];
    }
  }

  static Future<Channel?> fetchChannelItem(int id) async {
    final response = await RestClient.getHttp("/post/sub/source/detail/$id");
    if (RestClient.respSuccess(response)) {
      Map channelResult = response.data["result"];
      String jsonContent = JsonEncoder().convert(channelResult);
      Channel parseItem = Channel.fromJson(jsonContent);
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
