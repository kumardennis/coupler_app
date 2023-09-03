import 'package:coupler_app/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../utils/getSetUsSettings.dart';

class AddDatePopup extends HookWidget {
  final Function getDates;

  const AddDatePopup({super.key, required this.getDates});

  @override
  Widget build(BuildContext context) {
    ValueNotifier pickedDate = useState(null);

    TextEditingController textController = useTextEditingController();

    final UsSettingsHelper usSettingsHelper = UsSettingsHelper();

    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      pickedDate.value = args.value;
    }

    Future addDate() async {
      print(pickedDate.value);
      print(textController.text);

      await usSettingsHelper.setSpecialDates(
          pickedDate.value, textController.text);
      await getDates();

      Navigator.of(context).pop();
    }

    return AlertDialog(
      title: Text('btn_AddSpecialDate'.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 200,
            child: SfDateRangePicker(
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.single,
            ),
          ),
          TextField(
            controller: textController,
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.dark),
          child: Text(
            'btn_Close'.tr,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).colorScheme.light),
          ),
        ),
        TextButton(
          onPressed: () {
            addDate();
          },
          style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.darkPink),
          child: Text(
            'btn_Add'.tr,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).colorScheme.light),
          ),
        )
      ],
    );
  }
}
