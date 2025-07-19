import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/data/models/country.dart';
import 'package:football_app/modules/league_picker/controllers/league_season_picker_controller.dart';
import 'package:football_app/widgets/view_state_error_minimal_widget.dart';
import 'package:get/get.dart';

class CountryDropdown extends StatelessWidget {
  const CountryDropdown({
    super.key,
    required this.controller,
  });

  final LeagueSeasonPickerController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final state = controller.countriesState;

      if (state is ViewStateLoading) {
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: LinearProgressIndicator(),
        );
      }

      if (state is ViewStateError) {
        return SizedBox(
          height: 48,
          child: ViewStateErrorMinimalWidget(
            message: state.message,
            onRetry: controller.fetchCountries,
          ),
        );
      }

      if (state is ViewStateSuccess) {
        final countries = state.data;
        final selectedCountry = controller.selectedCountry.value;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownSearch<Country>(
            selectedItem: countries.contains(selectedCountry) ? selectedCountry : null,
            compareFn: (item1, item2) => item1.name.toLowerCase() == item2.name.toLowerCase(),
            filterFn: (item, filter) => item.name.toLowerCase().contains(filter.toLowerCase()),
            items: (filter, infiniteScrollProps) => countries,
            onChanged: (value) {
              if (value != null) controller.selectCountry(value);
            },
            popupProps: PopupProps.menu(
              title: const Text('Pilih Negara'),
              showSearchBox: true,
              itemBuilder: (context, item, isSelected, selectedItem) {
                return ListTile(
                  leading: SvgPicture.network(
                    item.flag,
                    width: 20,
                    height: 15,
                    placeholderBuilder: (context) => const SizedBox(
                      width: 20,
                      height: 15,
                      child: Center(child: CircularProgressIndicator(strokeWidth: 1.5)),
                    ),
                  ),
                  title: Text(item.name),
                );
              },
            ),
            dropdownBuilder: (context, selectedItem) {
              return Row(
                children: [
                  if (selectedItem != null)
                    SvgPicture.network(
                      selectedItem.flag,
                      width: 20,
                      height: 15,
                      placeholderBuilder: (context) => const SizedBox(
                        width: 20,
                        height: 15,
                        child: Center(child: CircularProgressIndicator(strokeWidth: 1.5)),
                      ),
                    ),
                  const SizedBox(width: 8),
                  Text(selectedItem?.name ?? ''),
                ],
              );
            },
            decoratorProps: DropDownDecoratorProps(
              decoration: const InputDecoration(
                hintText: 'Pilih Negara',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ),
        );
      }

      return const SizedBox(); // ViewStateInitial fallback
    });
  }
}
