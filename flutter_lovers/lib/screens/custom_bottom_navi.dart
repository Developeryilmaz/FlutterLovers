import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lovers/screens/tab_items.dart';

class CustomBottomNavi extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, Widget> createPage;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  const CustomBottomNavi({
    Key key,
    @required this.currentTab,
    @required this.onSelectTab,
    @required this.createPage,
    @required this.navigatorKeys,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _barItem(TabItem.AllPersons),
          _barItem(TabItem.Profile),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final _showItem = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKeys[_showItem],
          builder: (context) {
            return createPage[_showItem];
          },
        );
      },
    );
  }

  BottomNavigationBarItem _barItem(TabItem tabItem) {
    final tab = TabItemData.allTabs[tabItem];

    return BottomNavigationBarItem(icon: Icon(tab.iconData), label: tab.label);
  }
}
