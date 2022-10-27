import 'package:cruise/src/page/home/components/articledetail_component/article_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'article_detail_controller.dart';

class ArticleDetailView extends GetView<ArticleDetailController> {
  @override
  Widget build(BuildContext context) {
    return ArticleDetail();
  }
}
