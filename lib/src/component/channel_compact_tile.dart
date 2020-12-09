import 'package:Cruise/src/models/Channel.dart';
import 'package:flutter/material.dart';

class ChannelCompactTile extends StatelessWidget {
  const ChannelCompactTile({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Channel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
      ],
    );
  }
}
