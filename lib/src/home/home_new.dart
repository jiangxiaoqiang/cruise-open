import 'package:Cruise/src/component/home_list.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:Cruise/src/models/system_enumn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:Cruise/src/common/deeplink_handler.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/common/Repo.dart';

final FutureProvider topStories = FutureProvider((ref) async {
  ArticleRequest request = new ArticleRequest();
  request.storiesType = StoriesType.topStories;
  return await Repo.getArticles(request);
});

final FutureProvider newStories = FutureProvider((ref) async {
  ArticleRequest request = new ArticleRequest();
  request.storiesType = StoriesType.subStories;
  return await Repo.getArticles(request);
});

final FutureProvider bestStories = FutureProvider((ref) async {
  ArticleRequest request = new ArticleRequest();
  request.storiesType = StoriesType.channels;
  return await Repo.getArticles(request);
});

final FutureProvider showStories = FutureProvider((ref) async {
  ArticleRequest request = new ArticleRequest();
  request.storiesType = StoriesType.showStories;
  return await Repo.getArticles(request);
});

final FutureProvider jobStories = FutureProvider((ref) async {
  ArticleRequest request = new ArticleRequest();
  request.storiesType = StoriesType.jobStories;
  return await Repo.getArticles(request);
});

class IconTab {
  IconTab({
    this.name,
    this.icon,
  });

  final String name;
  final IconData icon;
}

class HomeNew extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useMemoized(() => DeeplinkHandler.init(context));
    useEffect(() => DeeplinkHandler.cancel, const []);

    var selectIndex = useState(0);
    var storyType = useState<StoriesType>(StoriesType.topStories);

    void _onItemTapped(int index) {
      if(index == MenuType.my.value) {
        selectIndex.value = index;
        storyType.value = StoriesType.profile;
      }
      if(index == MenuType.home.value){
        selectIndex.value = index;
        storyType.value = StoriesType.topStories;
      }
      if(index == MenuType.channels.value){
        selectIndex.value = index;
        storyType.value = StoriesType.channels;
      }
      if(index == MenuType.follow.value){
        selectIndex.value = index;
        storyType.value = StoriesType.subStories;
      }
    }

    void _onAdd(){
    }

    return Scaffold(
      body: HomeList(currentStoriesType: storyType.value),
      bottomNavigationBar: BottomNavigationBar( // 底部导航
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(icon: Icon(Icons.follow_the_signs), title: Text('关注')),
          BottomNavigationBarItem(icon: Icon(Icons.rss_feed), title: Text('频道')),
          BottomNavigationBarItem(icon: Icon(Icons.school),title: Text('我的')),
        ],
        currentIndex: selectIndex.value,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
        unselectedItemColor: Color(0xff666666),
        type: BottomNavigationBarType.fixed
      ),
    );
  }
}
