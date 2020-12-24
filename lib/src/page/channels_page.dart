import 'package:Cruise/src/component/channel_list.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:Cruise/src/component/loading_item.dart';
import 'package:Cruise/src/common/Repo.dart';

final storiesTypeProvider = FutureProvider.family((ref, type) async {
  return await Repo.getArticles(type);
});

final storyChannelProvider = FutureProvider.family((ref, id) async {
  return await Repo.fetchChannelItem(id);
});

class ChannelsPage extends HookWidget {
  const ChannelsPage({
    Key key,
    @required this.articleRequest,
  }) : super(key: key);

  final ArticleRequest articleRequest;

  @override
  Widget build(BuildContext context) {
    return Consumer(
            (context, read) {
          return read(storiesTypeProvider(articleRequest)).when(
            loading: () {
              // return SliverFillRemaining(
              // child: Center(child: CircularProgressIndicator()));
              return SliverToBoxAdapter(child: Center(child: LoadingItem()));
            },
            error: (err, stack) {
              print(err);
              return SliverToBoxAdapter(
                  child: Center(child: Text('Error: $err')));
            },
            data: (ids) {
              return ChannelList(ids: ids);
            },
          );
        },
      );
    }
  }
