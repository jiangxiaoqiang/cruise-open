import 'dart:async';

import 'package:cruise/src/common/repo.dart';
import 'package:cruise/src/models/Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

class DeeplinkHandler {
  static StreamSubscription? _sub;

  static void cancel() {
    if (_sub != null) _sub!.cancel();
  }

  static Future<StreamSubscription?> init(BuildContext context) async {
    // Platform messages are asynchronous, so we initialize in an async method.
    /// An implementation using a [Uri] link
    // Attach a listener to the links stream
    _sub = getUriLinksStream().listen((Uri uri) async {
      try {
        if (uri != null) {
          launchDeeplink(context, uri);
        }
      } on FormatException {}
    }, onError: (err) {
      print("deeplink failed to launch: $err");
    });

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      Uri uri = await getInitialUri();
      if (uri != null) launchDeeplink(context, uri);
    } on PlatformException {
      print('[PlatformException] Failed to get initial link.');
    } on FormatException {
      print('[FormatException] Failed to get initial link.');
    }

    return _sub;
  }
}

void launchDeeplink(BuildContext context, Uri uri) async {
  String? id = uri.queryParametersAll["id"] == null ? null : uri.queryParametersAll["id"]![0];
  if (id == null) return;
  ArticleItem item = (await Repo.fetchArticleItem(int.parse(id)))!;

  // TODO: A better UI for handling different types of Story, especially Comment.
  if (item.type == StoryType.story || item.type == StoryType.job || item.type == StoryType.poll || item.type == StoryType.comment) {
    /* Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StoryPage(item: item)),
    );*/
  } else {
    print("Type ${item.type} not handled");
  }
}
