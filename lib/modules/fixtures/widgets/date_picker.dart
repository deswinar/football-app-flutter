import 'package:flutter/material.dart';
import 'package:football_app/modules/fixtures/controllers/fixtures_controller.dart';
import 'package:get/get.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    required this.controller,
  });

  final FixturesController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Selected Date: ${controller.formattedDate}',
              style: const TextStyle(fontSize: 16),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.calendar_today),
              label: const Text('Pick Date'),
              onPressed: () async {
                final picked = await showDatePicker(
                  context: Get.context!,
                  initialDate: controller.selectedDate.value,
                  firstDate: DateTime(DateTime.now().year - 5),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                if (picked != null) {
                  controller.setDate(picked);
                }
              },
            ),
          ],
        );
      }),
    );
  }
}