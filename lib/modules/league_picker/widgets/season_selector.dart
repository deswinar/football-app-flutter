import 'package:flutter/material.dart';
import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/modules/league_picker/controllers/league_season_picker_controller.dart';
import 'package:football_app/widgets/view_state_error_minimal_widget.dart';
import 'package:get/get.dart';

class SeasonSelector extends StatelessWidget {
  const SeasonSelector({
    super.key,
    required this.controller,
  });

  final LeagueSeasonPickerController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final state = controller.seasonsState;

      if (state is ViewStateLoading) {
        return const SizedBox(
          height: 48,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (state is ViewStateError) {
        return SizedBox(
          height: 48,
          child: ViewStateErrorMinimalWidget(
            message: state.message,
            onRetry: controller.fetchSeasons,
          ),
        );
      }

      if (state is ViewStateSuccess<List<int>>) {
        final seasons = state.data;
        if (seasons.isEmpty) return const SizedBox.shrink();

        return SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: seasons.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, index) {
              final year = seasons[index];
              return Obx(() {
                final isSelected = year == controller.selectedSeason.value;
                return ChoiceChip(
                  label: Text('$year/${year + 1}'),
                  selected: isSelected,
                  onSelected: (_) => controller.selectSeason(year),
                );
              });
            },
          ),
        );
      }

      return const SizedBox.shrink(); // ViewStateInitial fallback
    });
  }
}
