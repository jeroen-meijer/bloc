import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_todos/models/models.dart';

class TabSelector extends StatelessWidget {
  const TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabSelected,
  }) : super(key: key);

  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: ArchSampleKeys.tabs,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: [
        for (final tab in AppTab.values)
          BottomNavigationBarItem(
            icon: Icon(
              tab == AppTab.todos ? Icons.list : Icons.show_chart,
              key: tab == AppTab.todos
                  ? ArchSampleKeys.todoTab
                  : ArchSampleKeys.statsTab,
            ),
            label: tab == AppTab.stats
                ? ArchSampleLocalizations.of(context).stats
                : ArchSampleLocalizations.of(context).todos,
          ),
      ],
    );
  }
}
