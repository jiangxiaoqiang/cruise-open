import 'dart:convert';

import 'package:cruise/src/common/history.dart';
import 'package:cruise/src/models/Item.dart';
import 'package:timeago/timeago.dart' as timeago;

class Channel {
  Channel(
      {this.depth = 0,
      this.author = "Unknown",
      this.deleted = false,
      this.content = "",
      this.dead = false,
      this.poll = 0,
      this.parent = 0,
      this.parts,
      this.descendants,
      this.id = "0",
      this.kids,
      this.score = 0,
      this.iconData = "",
      this.pubTime = 0,
      this.title = "Unknown",
      this.subName = "Unknown",
      this.subUrl = "",
      this.isFav = 0,
      this.intro = "",
      this.favIconUrl = "",
      this.localIconUrl = "",
      this.articleDTOList});

  int depth;
  String author;
  String iconData;
  bool deleted;
  String content;
  bool dead;
  int poll;
  int parent;
  List<int>? parts;
  int? descendants;
  String id;
  List<int>? kids;
  int score;
  int pubTime;
  String title;
  String subName;
  String subUrl;
  int isFav;
  String intro;
  String favIconUrl;
  String localIconUrl;
  List<ArticleItem>? articleDTOList;

  factory Channel.fromJson(String str) => Channel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  bool isVoted() => HistoryManager.isVoted(id);

  String get ago => timeago.format(DateTime.fromMillisecondsSinceEpoch(pubTime));

  factory Channel.fromMap(Map<String, dynamic> json) => Channel(
      id: json["id"],
      isFav: json["isFav"] == null ? 0 : json["isFav"],
      author: json["author"] == null ? "" : json["author"],
      deleted: json["deleted"] == null ? false : json["deleted"],
      content: json["content"] == null ? "" : json["content"],
      dead: json["dead"] == null ? false : json["dead"],
      pubTime: json["pubTime"] == null ? 0 : json["pubTime"],
      title: json["title"] == null ? "" : json["title"],
      subName: json["subName"] == null ? "" : json["subName"],
      subUrl: json["subUrl"] == null ? "" : json["subUrl"],
      intro: json["intro"] == null ? "" : json["intro"],
      favIconUrl: json["favIconUrl"] == null ? "" : json["favIconUrl"],
      localIconUrl: json["localIconUrl"] == null ? "" : json["localIconUrl"],
      iconData: json["iconData"] == null ? "" : json["iconData"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "author": author == null ? null : author,
        "deleted": deleted == null ? null : deleted,
        "content": content == null ? null : content,
        "dead": dead == null ? null : dead,
        "poll": poll == null ? null : poll,
        "parent": parent == null ? null : parent,
        "parts": parts == null ? null : List<dynamic>.from(parts!.map((x) => x)),
        "descendants": descendants == null ? null : descendants,
        "kids": kids == null ? null : List<dynamic>.from(kids!.map((x) => x)),
        "score": score == null ? null : score,
        "pubTime": pubTime == null ? null : pubTime,
        "title": title == null ? null : title,
        "subName": subName == null ? null : subName,
        "subUrl": subUrl == null ? null : subUrl,
        "isFav": isFav == null ? null : isFav,
        "intro": intro == null ? null : intro,
        "favIconUrl": favIconUrl == null ? null : favIconUrl,
        "localIconUrl": localIconUrl == null ? null : localIconUrl,
        "iconData": iconData == null ? null : iconData,
      };
}
