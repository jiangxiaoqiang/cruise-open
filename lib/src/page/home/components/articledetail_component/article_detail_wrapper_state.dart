import 'package:flutter/material.dart';

import 'article_detail_view.dart';
import 'article_detail_wrapper.dart';

class ArticleDetailWrapperState extends State<ArticleDetailWrapper> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ArticleDetailView();
  }

  @override
  bool get wantKeepAlive => true;
}
