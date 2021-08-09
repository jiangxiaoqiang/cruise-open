import 'package:cruise/src/common/view_manager.dart';
import 'package:cruise/src/component/compact_tile.dart';
import 'package:cruise/src/component/item_card.dart';
import 'package:cruise/src/component/item_tile.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:cruise/src/common/auth.dart';
import 'package:cruise/src/common/history.dart';
import 'package:cruise/src/models/Item.dart';
import 'net/rest/http_result.dart';
import 'config/cruise_global_config.dart';

void handleShare({required String id, required String title, required String postUrl}) {
  String hnUrl = buildShareURL(id);
  String text =
      "Read it on Cruise: $hnUrl \r\r or go straight to the article: $postUrl";
  Share.share(text, subject: title);
}

String buildShareURL(String id) {
  return shareUrl + "/product/cruise/share/$id";
}

void handleUpvote(context, {required Item item}) async {
  HistoryManager.addToVoteCache(item.id);
  AuthResult result = await Auth.vote(itemId: "${item.id}");

  if (result.result == Result.error) {
    HistoryManager.removeFromVoteCache(
        item.id); // ToDO: The UI won't update when we remove from cache here.
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(result.message)));
  } else if (result.result == Result.ok) {
    await HistoryManager.markAsVoted(item.id);
  }
}

Widget getViewType(ViewType type, Item item) {
  switch (type) {
    case ViewType.compactTile:
      return CompactTile(item: item);
      break;
    case ViewType.itemCard:
      return ItemCard(item: item);
      break;
    case ViewType.itemTile:
      return ItemTile(item: item);
      break;
    default:
      return ItemCard(item: item);
      break;
  }
}
