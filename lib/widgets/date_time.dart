import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:cashcue/widgets/text.dart';
import 'package:flutter/material.dart';

class PickerItemWidget extends StatelessWidget {
  PickerItemWidget({
    super.key,
    required this.pickerType,
    required this.onDateTimeChanged, 
  });

  final DateTimePickerType pickerType;
  final ValueNotifier<DateTime> date = ValueNotifier(DateTime.now());
  final Function(DateTime) onDateTimeChanged; 

  @override
  Widget build(BuildContext context) {
    final controller = BoardDateTimeController();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final result = await showBoardDateTimePicker(
            context: context,
            pickerType: pickerType,
            options: const BoardDateTimeOptions(
              languages: BoardPickerLanguages.en(),
              startDayOfWeek: DateTime.sunday,
              pickerFormat: PickerFormat.ymd,
            ),
            maximumDate: DateTime.now(),
            valueNotifier: date,
            controller: controller,
          );
          if (result != null) {
            date.value = result;
            onDateTimeChanged(result); 
            print('result: $result');
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            children: [
              const Expanded(
                child: CustomText(text: 'Date and Time', color: Color.fromRGBO(143, 142, 148, 1), fontfamily: 'Urbanist', fontSize: 16,)
              ),
              ValueListenableBuilder(
                valueListenable: date,
                builder: (context, data, _) {
                  return Text(
                    BoardDateFormat(pickerType.formatter(
                      withSecond: DateTimePickerType.time == pickerType,
                    )).format(data),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension DateTimePickerTypeExtension on DateTimePickerType {

  String formatter({bool withSecond = false}) {
    switch (this) {
      case DateTimePickerType.date:
        return 'yyyy/MM/dd';
      case DateTimePickerType.datetime:
        return 'yyyy/MM/dd HH:mm';
      case DateTimePickerType.time:
        return withSecond ? 'HH:mm:ss' : 'HH:mm';
    }
  }
}
