import 'package:flutter/material.dart';
import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/modules/fixtures/controllers/fixtures_controller.dart';
import 'package:football_app/modules/fixtures/models/fixture_response.dart';
import 'package:football_app/modules/fixtures/widgets/date_picker.dart';
import 'package:football_app/modules/fixtures/widgets/fixtures_list.dart';
import 'package:get/get.dart';

class FixturesScreen extends StatelessWidget {
  const FixturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FixturesController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fixtures'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.fetchLiveFixtures,
            tooltip: 'Live Fixtures',
          ),
        ],
      ),
      body: Column(
        children: [
          DatePicker(controller: controller),
          Expanded(
            child: Obx(() {
              final state = controller.fixturesState;

              if (state is ViewStateLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ViewStateError) {
                final error = state;
                return Center(child: Text('Error: ${error.message}'));
              } else if (state is ViewStateSuccess<List<FixtureEntry>>) {
                final fixtures = state.data;
                if (fixtures.isEmpty) {
                  return const Center(child: Text('No fixtures available.'));
                }

                return FixturesList(fixtures: fixtures);
              }

              return const SizedBox(); // ViewStateInitial
            }),
          ),
        ],
      ),
    );
  }
}
