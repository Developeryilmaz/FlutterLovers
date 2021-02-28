import 'package:flutter/material.dart';
import 'package:flutter_lovers/model/person.dart';
import 'package:flutter_lovers/screens/custom_bottom_navi.dart';
import 'package:flutter_lovers/screens/persons_page.dart';
import 'package:flutter_lovers/screens/profile_page.dart';
import 'package:flutter_lovers/screens/tab_items.dart';

class HomePage extends StatefulWidget {
  final Person person;

  const HomePage({Key key, @required this.person}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.AllPersons;
  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.AllPersons: GlobalKey<NavigatorState>(),
    TabItem.Profile: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, Widget> allPages() {
    return {
      TabItem.AllPersons: PersonsPage(),
      TabItem.Profile: ProfilePage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: Container(
        child: CustomBottomNavi(
          navigatorKeys: navigatorKeys,
          createPage: allPages(),
          currentTab: _currentTab,
          onSelectTab: (selectTab) {
            if (selectTab == _currentTab) {
              navigatorKeys[selectTab].currentState.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                _currentTab = selectTab;
              });
            }
          },
        ),
      ),
    );
  }
}

/*
  Future<bool> _userExit({BuildContext context}) async {
    final _personModel = Provider.of<UserViewModel>(context, listen: false);
    bool result = await _personModel.signOut();
    return result;
  }
  */
