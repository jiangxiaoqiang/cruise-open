import 'dart:async';
import 'dart:convert';

import 'package:Cruise/src/common/CruiseUser.dart';
import 'package:Cruise/src/common/global.dart' as global;
import 'package:Cruise/src/common/log/CruiseLogHandler.dart';
import 'package:Cruise/src/common/net/rest/rest_clinet.dart';
import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:http/http.dart' as http;

import 'log/cruise_api_error.dart';

class Repo {
  static final _itemsCache = <int, Item>{};
  static final _itemsChannelCache = <int, Channel>{};
  static final _usersCache = <String, CruiseUser>{};
  static const baseUrl = global.baseUrl;

  static Future<List<int>> getElementIds(ArticleRequest request) async {
    return await _getIds(request);
  }

  static Future<List<String>> getCommentsIds({Item item}) async {
    Stream<Item> stream = lazyFetchComments(item: item, assignDepth: false);
    List<String> comments = [];
    await for (Item comment in stream) {
      comments.add(comment.id);
    }
    return comments;
  }

  static Stream<Item> lazyFetchComments({Item item, int depth = 0, bool assignDepth = true}) async* {
    if (item.kids.isEmpty) return;
    for (int kidId in item.kids) {
      Item kid = await fetchArticleItem(kidId);
      if (kid == null) continue;
      if (assignDepth) kid.depth = depth;
      yield kid;
      Stream stream = lazyFetchComments(item: kid, depth: kid.depth + 1);
      await for (Item grandkid in stream) {
        yield grandkid;
      }
    }
  }

  static Future<List<Item>> prefetchComments({Item item}) async {
    List<Item> result = [];
    if (item.parent != null) result.add(item);
    if (item.kids.isEmpty) return Future.value(result);

    await Future.wait(item.kids.map((kidId) async {
      Item kid = await fetchArticleItem(kidId);
      if (kid != null) {
        await prefetchComments(item: kid);
      }
    }));
    return Future.value(result);
  }

  static Future<List<Item>> fetchByIds(List<int> ids) async {
    return Future.wait(ids.map((itemId) {
      return fetchArticleItem(itemId);
    }));
  }

  static Future<List<int>> _getIds(ArticleRequest articleRequest) async {
    final typeQuery = _getStoryTypeQuery(articleRequest.storiesType);
    Map jsonMap = articleRequest.toMap();
    final response = await RestClient.postHttp("$typeQuery", jsonMap);
    if (response.statusCode == 200 && response.data["statusCode"] == "200") {
      Map result = response.data["result"];
      if (result == null) {
        return new List();
      }
      var articles = result["list"];
      List<String> genreIdsList = new List<String>.from(articles);
      List<int> intIds = genreIdsList.map(int.parse).toList();
      return intIds;
    } else {
      CruiseLogHandler.logError(CruiseApiError('Stories failed to fetch.'), JsonEncoder().convert(response));
    }
  }

  static Future<Item> fetchArticleItem(int id) async {
    if (_itemsCache.containsKey(id)) {
      return _itemsCache[id];
    } else {
      final response = await RestClient.getHttp("/post/article/$id");
      if (response.statusCode == 200 && response.data["statusCode"] == "200") {
        Map articleResult = response.data["result"];
        String articleJson = JsonEncoder().convert(articleResult);
        Item parseItem = Item.fromJson(articleJson);
        _itemsCache[id] = parseItem;
      } else {
        CruiseLogHandler.logError(CruiseApiError('Item $id failed to fetch.'), JsonEncoder().convert(response));
      }
      return _itemsCache[id];
    }
  }

  static Future<Channel> fetchChannelItem(int id) async {
    if (_itemsChannelCache.containsKey(id)) {
      return _itemsChannelCache[id];
    } else {
      final response = await RestClient.getHttp("/post/sub/source/detail/$id");
      if (response.statusCode == 200 && response.data["statusCode"] == "200") {
        Map channelResult = response.data["result"];
        String jsonContent = JsonEncoder().convert(channelResult);
        Channel parseItem = Channel.fromJson(jsonContent);
        _itemsChannelCache[id] = parseItem;
      } else {
        CruiseLogHandler.logError(CruiseApiError('Item $id failed to fetch.'), JsonEncoder().convert(response));
      }
    }
    return _itemsChannelCache[id];
  }

  static Future<CruiseUser> fetchUser(String id) async {
    if (_usersCache.containsKey(id)) {
      return _usersCache[id];
    } else {
      String url = "$baseUrl/user/$id.json";
      final response = await http.get(url);
      if (response.statusCode == 200) {
        if (response.body == "null") return null;
        _usersCache[id] = CruiseUser.fromJson(response.body);
      } else {
        CruiseLogHandler.logError(CruiseApiError('User $id failed to fetch.'), JsonEncoder().convert(response));
      }
    }
    return _usersCache[id];
  }

  static String _getStoryTypeQuery(StoriesType type) {
    switch (type) {
      case StoriesType.channels:
        return "/post/sub/source/ids";
      case StoriesType.subStories:
        return "/post/article/substories";
        break;
      case StoriesType.topStories:
        return "/post/article/newstories";
        break;
      case StoriesType.showStories:
        return "/post/article/newstories";
        break;
      case StoriesType.jobStories:
        return "/post/article/newstories";
        break;
      case StoriesType.favStories:
        return "/post/user/fav/article";
        break;
      case StoriesType.originalStories:
        return "/post/article/originalstories";
        break;
      default:
        return "/post/article/newstories";
    }
  }
}
