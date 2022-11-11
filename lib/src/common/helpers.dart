import 'package:cruise/src/common/history.dart';
import 'package:cruise/src/common/view_manager.dart';
import 'package:cruise/src/component/compact_tile.dart';
import 'package:cruise/src/component/item_card.dart';
import 'package:cruise/src/component/item_tile.dart';
import 'package:cruise/src/models/Item.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wheel/wheel.dart';

void handleShare({required String id, required String title, required BuildContext context, required String postUrl}) {
  // _onShare method:
  final box = context.findRenderObject() as RenderBox?;
  String hnUrl = buildShareURL(id);
  String text = "Read it on Cruise: $hnUrl \r\r or go straight to the article: $postUrl";
  Share.share(text, subject: title, sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
}

String buildShareURL(String id) {
  return GlobalConfig.getShareUrl() + "/product/cruise/share/$id";
}

void handleUpvote(context, {required ArticleItem item}) async {
  HistoryManager.addToVoteCache(item.id);
  AuthResult result = await Auth.vote(itemId: "${item.id}");

  if (result.result == Result.error) {
    HistoryManager.removeFromVoteCache(item.id); // ToDO: The UI won't update when we remove from cache here.
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result.message)));
  } else if (result.result == Result.ok) {
    await HistoryManager.markAsVoted(item.id);
  }
}

Widget getViewType(ViewType type, ArticleItem item) {
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
