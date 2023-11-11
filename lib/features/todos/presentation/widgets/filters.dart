import 'package:flutter/material.dart';
import 'package:flutter_todo_app/features/todos/presentation/resources/filter.dart';

import 'filter_button.dart';

class Filters extends StatelessWidget {
  const Filters({
    super.key,
    required this.activeFilter,
    required this.onFilterChange,
  });

  final Filter activeFilter;
  final void Function(Filter) onFilterChange;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 520;

    return Row(
      mainAxisAlignment: isMobile
        ? MainAxisAlignment.spaceEvenly
        : MainAxisAlignment.center,
      children: Filter.values.map((filter) {
        Widget button = FilterButton(
          text: filter.label,
          isSelected: activeFilter == filter,
          onPressed: () {
            onFilterChange(filter);
          },
        );

        return isMobile
          ? Expanded(
            child: button,
          )
          : button;
      }).toList(),
    );
  }
}