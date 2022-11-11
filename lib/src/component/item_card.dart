import 'package:cruise/src/models/Item.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ArticleItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(item.id.toString()),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.domain.isEmpty ? "--" : item.domain,
                style: Theme.of(context).textTheme.caption,
              ),
              if (item.type == StoryType.comment)
                Text(
                  "Comment",
                  style: Theme.of(context).textTheme.caption,
                ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8.0),
                child: item.type == StoryType.comment
                    ? Html(data: item.content)
                    : Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
                      children: [
                        Icon(
                          EvaIcons.clock,
                          size: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            item.ago,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
