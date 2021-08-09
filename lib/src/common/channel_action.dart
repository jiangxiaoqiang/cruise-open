import 'dart:convert';

import 'package:cruise/src/common/config/cruise_global_config.dart' as global;
import 'package:cruise/src/common/net/rest/legacy_rest_clinet.dart';
import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/models/api/sub_status.dart';
import 'package:cruise/src/models/channel_suggestion.dart';
import 'package:cruise/src/models/request/channel/channel_request.dart';
import 'package:dio/dio.dart';
import 'package:wheel/wheel.dart' show AppLogHandler, RestApiError;
import 'log/cruise_log_handler.dart';
import 'log/cruise_api_error.dart';
import 'net/rest/http_result.dart';

class ChannelAction {
  final baseUrl = global.baseUrl;

  static Future<HttpResult> sub({required String channelId, required SubStatus subStatus}) async {
    String url = "/post/sub/source/" + subStatus.statusCode + "/" + channelId;
    final response = await LegacyRestClient.putHttp(url, null);
    if (LegacyRestClient.respSuccess(response)) {
      return HttpResult(message: "SMS send success", result: Result.ok);
    } else {
      return HttpResult(message: "Sub failed.", result: Result.error);
    }
  }

  static Future<HttpResult> addChannel({required String url}) async {
    Map body = {"subUrl": url};
    final response = await LegacyRestClient.postHttp("/post/sub/source/add", body);
    if (LegacyRestClient.respSuccess(response)) {
      return HttpResult(message: "Channel add success", result: Result.ok);
    } else {
      return HttpResult(message: "Sub failed.", result: Result.error);
    }
  }

  static Future<List<Channel>> searchChannel(ChannelRequest request) async {
    Map jsonMap = request.toMap();
    final response = await LegacyRestClient.postHttp("/post/sub/source/page", jsonMap);
    return convertTheResult(response);
  }

  static Future<List<ChannelSuggestion>> fetchSuggestion(ChannelRequest request) async {
    Map jsonMap = request.toMap();
    final response = await LegacyRestClient.postHttp("/post/sub/source/suggestion", jsonMap);
    return convertSuggestionResult(response);
  }

  static List<ChannelSuggestion> convertSuggestionResult(Response response) {
    if (LegacyRestClient.respSuccess(response)) {
      var channelResult = response.data["result"];
      if (channelResult == null) {
        return List.empty();
      }
      List<ChannelSuggestion> channelSuggestion = [];
      channelResult.forEach((element) {
        try {
          ChannelSuggestion parsedChannel = ChannelSuggestion.fromMap(element);
          if (parsedChannel != null) {
            channelSuggestion.add(parsedChannel);
          }
        } on Exception catch (e) {
          AppLogHandler.logError(RestApiError('Channel suggestion parsed failed.'), JsonEncoder().convert(response));
        }
      });
      return channelSuggestion;
    }
    return List.empty();
  }

  static List<Channel> convertTheResult(Response response) {
    if (LegacyRestClient.respSuccess(response)) {
      var channelResult = response.data["result"];
      if (channelResult == null) {
        return List.empty();
      }
      var channelListResult = channelResult["list"];
      List<Channel> channels = [];
      channelListResult.forEach((element) {
        try {
          Channel parsedChannel = Channel.fromMap(element);
          channels.add(parsedChannel);
        } on Exception catch (e) {
          AppLogHandler.logError(RestApiError('Channel parsed failed.'), JsonEncoder().convert(response));
        }
      });
      return channels;
    }
    return List.empty();
  }
}
