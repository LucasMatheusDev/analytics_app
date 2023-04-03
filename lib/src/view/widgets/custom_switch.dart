import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final Icon icon;
  final String title;
  final bool value;
  final void Function() onChanged;

  const CustomSwitch({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final reactiveValue = ValueNotifier<bool>(value);
    return Row(
      children: [
        icon,
        const SizedBox(width: 5),
        Text(title),
        const SizedBox(width: 10),
        ValueListenableBuilder(
          valueListenable: reactiveValue,
          builder: (context, value, child) => Switch(
            value: value,
            onChanged: (value) {
              reactiveValue.value = value;
              onChanged();
            },
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
