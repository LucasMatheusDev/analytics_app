import 'package:analytics_app/analytics_app.dart';

abstract class HomeDataSource {
  Future<String> getResponse();
}

class HomeDataSourceImpl implements HomeDataSource {
  @override
  Future<String> getResponse() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Success';
  }
}

class MockHomeDataSource extends MockDataSource implements HomeDataSource {
  MockHomeDataSource({
    super.routeName = '/home',
    super.friendlyName = 'Home Data Source',
  });

  @override
  List<PossibleAnswer> get possibleAnswers => [
        PossibleAnswer(
          label: 'Success',
          description: 'Success description',
          id: 1,
        ),
        PossibleAnswer(
          label: 'Default error',
          description: 'Default error description',
          id: 2,
        ),
      ];

  @override
  Future<String> getResponse() async {
    final chooseIndex = returnSelected?.id;
    await Future.delayed(const Duration(seconds: 1));
    if (chooseIndex == null || chooseIndex == 1) {
      registerRequest(
        request: 'Usuário 1',
        response: 'Success',
        name: 'Home data source',
      );
      return 'Success';
    } else {
      registerRequest(
        request: 'Usuário 2',
        response: 'Servidor error',
        name: 'Home data source',
      );
      return 'Default error';
    }
  }
}
