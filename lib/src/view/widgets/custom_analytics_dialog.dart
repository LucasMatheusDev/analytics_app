import 'package:analytics_app/src/material_app_resources.dart';
import 'package:analytics_app/src/view/widgets/custom_switch.dart';
import 'package:flutter/material.dart';

class CustomAnalyticsDialog extends StatelessWidget {
  final MaterialAppResources materialAppResources;
  const CustomAnalyticsDialog({
    super.key,
    required this.materialAppResources,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Analyze options '),
      content: Wrap(
        children: [
          CustomSwitch(
            icon: const Icon(Icons.grid_on),
            title: 'Enable grid',
            value: materialAppResources.isOpenGrid,
            onChanged: materialAppResources.upDateShowGrid,
          ),
          CustomSwitch(
            icon: const Icon(Icons.add_card_sharp),
            title: 'Enable banner',
            value: materialAppResources.isShowBanner,
            onChanged: materialAppResources.upDateShowBanner,
          ),
          CustomSwitch(
            title: 'Enable performance',
            icon: const Icon(Icons.auto_graph),
            value: materialAppResources.isShowPerformance,
            onChanged: materialAppResources.upDateShowPerformance,
          ),
          CustomSwitch(
            icon: const Icon(Icons.colorize),
            title: 'Enable paint',
            value: materialAppResources.isShowPaint,
            onChanged: materialAppResources.upDateShowPaint,
          ),
        ],
      ),
    );
  }
}
