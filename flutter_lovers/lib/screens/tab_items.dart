import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { AllPersons, Profile }

class TabItemData {
  final String label;
  final IconData iconData;

  TabItemData({this.label, this.iconData});

  static Map<TabItem, TabItemData> allTabs = {
    TabItem.AllPersons: TabItemData(label: 'Users', iconData: Icons.perm_contact_calendar),
    TabItem.Profile: TabItemData(label: 'Profile', iconData: Icons.person),
  };
}
