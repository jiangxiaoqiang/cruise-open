import 'package:cruise/src/common/helpers.dart';
import 'package:cruise/src/common/repo.dart';
import 'package:cruise/src/component/comment_tile.dart';
import 'package:cruise/src/component/loading_item.dart';
import 'package:cruise/src/models/Item.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CommentList extends HookWidget {
  const CommentList({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ArticleItem item;

  @override
  Widget build(BuildContext context) {
    useMemoized(() => Repo.prefetchComments(item: item));

    final collapsed = useState(Set());
    final comments = useState([]);

    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            Set result = Set.from(collapsed.value);
            Widget _child;

            if (comments.value.isEmpty || index > comments.value.length - 1) {
              _child = LoadingItem(count: 1);
            } else {
              ArticleItem comment = comments.value[index];

              _child = InkWell(
                onTap: () async {
                  if (collapsed.value.contains(comment.id)) {
                    result.remove(comment.id);
                  } else {
                    result.add(comment.id);
                    List<String> ids = await Repo.getCommentsIds(item: comment);
                    result.addAll(ids);
                  }
                  collapsed.value = result;
                },
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  child: collapsed.value.contains(comment.parent)
                      ? Container()
                      : Slidable(
                          key: Key(comment.id.toString()),
                          closeOnScroll: true,
                          actionPane: SlidableScrollActionPane(),
                          actions: <Widget>[
                            IconSlideAction(
                              color: Colors.deepOrangeAccent,
                              icon: EvaIcons.arrowUp,
                              onTap: () {
                                handleUpvote(context, item: comment);
                              },
                            ),
                          ],
                          dismissal: SlidableDismissal(
                            closeOnCanceled: true,
                            dismissThresholds: {
                              SlideActionType.primary: 0.2,
                              SlideActionType.secondary: 0.2,
                            },
                            child: SlidableDrawerDismissal(),
                            onWillDismiss: (actionType) {
                              handleUpvote(context, item: comment);
                              return false;
                            },
                          ),
                          child: CommentTile(
                            comment: comments.value[index],
                            author: item.author,
                            isCollapsed: collapsed.value.contains(comment.id),
                          ),
                        ),
                ),
              );
            }

            return AnimatedSwitcher(
              switchInCurve: Curves.easeInOut,
              duration: Duration(seconds: 1),
              child: _child,
            );
          },
          childCount: item.descendants,
        ),
      ),
    );
  }
}
