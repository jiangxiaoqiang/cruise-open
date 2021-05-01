import 'dart:convert';

import 'package:cruise/src/common/history.dart';
import 'package:timeago/timeago.dart' as timeago;

enum StoryType {
  job,
  story,
  comment,
  poll,
  pollopt,
}

enum StoriesType {
  topStories,
  subStories,
  channels,
  profile,
  showStories,
  jobStories,
  favStories,
  originalStories,
  channelStories
}

enum ArticleLoadingStatus { loading, complete }

class Item {
  Item(
      {this.depth = 0,
      this.author = "Unknown",
      this.deleted = false,
      this.content = '',
      this.dead,
      this.poll,
      this.parent,
      this.parts,
      this.descendants,
      this.id = "0",
      this.kids,
      this.score,
      this.pubTime = 0,
      this.title = "Unknown",
      this.type,
      this.link = "",
      this.isFav,
      this.favCount = 0,
      this.subSourceId = "0",
      this.isUpvote,
      this.upvoteCount = 0});

  int depth;
  String author;
  bool deleted;
  String content;
  bool? dead;
  int? poll;
  int? parent;
  List<int>? parts;
  int? descendants;
  String id;
  List<int>? kids;
  int? score;
  int pubTime;
  String title;
  StoryType? type;
  String link;
  int? isFav;
  int favCount;
  int? isUpvote;
  int upvoteCount;
  String subSourceId;

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  bool isVoted() => HistoryManager.isVoted(id);

  String get domain => Uri.parse(link).host;

  String get ago => timeago.format(DateTime.fromMillisecondsSinceEpoch(pubTime));

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["id"],
        author: json["author"] == null ? "" : json["author"],
        deleted: json["deleted"] == null ? false : json["deleted"],
        content: json["content"] == null ? "" : json["content"],
        dead: json["dead"] == null ? false : json["dead"],
        poll: json["poll"] == null ? null : json["poll"],
        parent: json["parent"] == null ? null : json["parent"],
        parts: json["parts"] == null ? [] : List<int>.from(json["parts"].map((x) => x)),
        descendants: json["descendants"] == null ? 0 : json["descendants"],
        kids: json["kids"] == null ? [] : List<int>.from(json["kids"].map((x) => x)),
        score: json["score"] == null ? 0 : json["score"],
        pubTime: json["pubTime"] == null ? 0 : json["pubTime"],
        title: json["title"] == null ? "" : json["title"],
        type: json["type"] == null ? StoryType.job : castType(json["type"]),
        link: json["link"] == null ? "" : json["link"],
        isFav: json["isFav"] == null ? 0 : json["isFav"],
        favCount: json["favCount"] == null ? 0 : json["favCount"],
        isUpvote: json["isUpvote"] == null ? 0 : json["isUpvote"],
        upvoteCount: json["upvoteCount"] == null ? 0 : json["upvoteCount"],
        subSourceId: json["subSourceId"] == null ? "" : json["subSourceId"],
      );

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
        "type": type == null ? null : type,
        "link": link == null ? null : link,
        "isFav": isFav == null ? null : isFav,
        "favCount": favCount == null ? null : favCount,
        "isUpvote": isUpvote == null ? null : isUpvote,
        "upvoteCount": upvoteCount == null ? null : upvoteCount,
        "subSourceId": subSourceId == null ? null : subSourceId,
      };

  static StoryType castType(String type) {
    switch (type) {
      case "job":
        return StoryType.job;
        break;
      case "story":
        return StoryType.story;
        break;
      case "comment":
        return StoryType.comment;
        break;
      case "poll":
        return StoryType.poll;
        break;
      case "pollopt":
        return StoryType.pollopt;
        break;
      default:
        return StoryType.job;
        break;
    }
  }
}
