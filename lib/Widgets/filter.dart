import 'package:flutter/material.dart';
import 'package:to_do_app/Widgets/filter_chip.dart';

enum TaskFilter { all, completed, pending }

class FilterChip extends StatelessWidget {
  final TaskFilter currentFilter;
  final Function(TaskFilter) onFilterChanged;

  const FilterChip({
    required this.currentFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilterChipWidget(
          label: 'All',
          isSelected: currentFilter == TaskFilter.all,
          onSelected: () => onFilterChanged(TaskFilter.all),
        ),
        SizedBox(width: 8),
        FilterChipWidget(
          label: 'Completed',
          isSelected: currentFilter == TaskFilter.completed,
          onSelected: () => onFilterChanged(TaskFilter.completed),
        ),
        SizedBox(width: 8),
        FilterChipWidget(
          label: 'Pending',
          isSelected: currentFilter == TaskFilter.pending,
          onSelected: () => onFilterChanged(TaskFilter.pending),
        ),
      ],
    );
  }
}
