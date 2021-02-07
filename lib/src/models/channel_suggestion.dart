import 'dart:convert';
import 'dart:wasm';

import 'package:Cruise/src/common/history.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChannelSuggestion {
  ChannelSuggestion({
    this.name,
    this.priority,
  });

  String name;
  double priority;

  factory ChannelSuggestion.fromJson(String str) => ChannelSuggestion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChannelSuggestion.fromMap(Map<String, dynamic> json) => ChannelSuggestion(
        name: json["name"],
        priority: json["priority"] == null ? 0.0 : json["priority"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "priority": priority == null ? null : priority
      };
}
