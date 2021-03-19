import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChannelList extends HookWidget {
  const ChannelList({
    required Key key,
    required this.ids,
  }) : super(key: key);

  final List<int> ids;
  
  @override
  Widget build(BuildContext context) {

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
        },
        childCount: ids.length,
      ),
    );
  }

}
