import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../home/components/homelist_component/home_list.dart';

class Fav extends HookWidget {
  Fav({
    Key? key,
    required this.currentStoriesType,
  }) : super(key: key);

  final StoriesType currentStoriesType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: HomeList()));
  }
}
