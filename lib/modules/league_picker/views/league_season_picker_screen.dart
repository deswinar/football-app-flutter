import 'package:flutter/material.dart';
import 'package:football_app/modules/league_picker/widgets/country_dropdown.dart';
import 'package:football_app/modules/league_picker/widgets/league_list.dart';
import 'package:football_app/modules/league_picker/controllers/league_season_picker_controller.dart';
import 'package:football_app/modules/league_picker/widgets/season_selector.dart';
import 'package:get/get.dart';

class LeagueSeasonPickerScreen extends GetView<LeagueSeasonPickerController> {
  const LeagueSeasonPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select League & Season'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          CountryDropdown(controller: controller),
          const SizedBox(height: 12),
          SeasonSelector(controller: controller),
          const Divider(height: 1),
          Expanded(child: LeagueList(controller: controller)),
        ],
      ),
    );
  }
}