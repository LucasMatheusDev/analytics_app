import 'package:analytics_app/src/mock_data_source.dart';
import 'package:analytics_app/src/models/possible_answer.dart';
import 'package:flutter/material.dart';

class CustomAnswerDialog extends StatelessWidget {
  final List<MockDataSource> dataSources;
  final void Function(PossibleAnswer answer) onSelected;
  const CustomAnswerDialog({
    super.key,
    required this.dataSources,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: FittedBox(
        child: Text('Data Source: ${dataSources.first.friendlyName}'),
      ),
      content: Wrap(
        children: [
          dataSources.isEmpty || dataSources.first.possibleAnswers.isEmpty
              ? const Text('No data sources')
              : Column(
                  children: [
                    Text(
                        'Choose answer for ${dataSources.first.friendlyName} '),
                    ...dataSources
                        .map(
                          (dataSource) => CustomSelectAnswer(
                            dataSource: dataSource,
                            onSelected: (answer) {
                              dataSource.selectAnswer(answer);
                              onSelected(answer);
                            },
                          ),
                        )
                        .toList(),
                    const SizedBox(height: 10),
                  ],
                ),
        ],
      ),
      actions: [
        ElevatedButton(
          child: const Text('Reset all answers'),
          onPressed: () {
            for (var dataSource in dataSources) {
              dataSource.resetAnswer();
            }
          },
        ),
      ],
    );
  }
}

class CustomSelectAnswer extends StatelessWidget {
  final MockDataSource dataSource;
  final void Function(PossibleAnswer answer) onSelected;
  const CustomSelectAnswer({
    super.key,
    required this.dataSource,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final possibleAnswers = [...dataSource.possibleAnswers];
    final value = ValueNotifier(PossibleAnswer(label: 'Select answer', id: 0));
    possibleAnswers.add(value.value);
    return Visibility(
      visible: possibleAnswers.isNotEmpty,
      child: ValueListenableBuilder(
        valueListenable: value,
        builder: (context, lastSelected, child) =>
            DropdownButton<PossibleAnswer>(
          value: lastSelected,
          onChanged: (answer) {
            if (value.value != answer) {
              value.value = answer!;
              onSelected(answer);
              Navigator.of(context).pop();
            }
          },
          items: possibleAnswers
              .map((answer) => DropdownMenuItem(
                    value: answer,
                    child: Text(answer.label),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
