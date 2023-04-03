import 'package:analytics_app/analytics_app.dart';

abstract class LoginDataSource {
  Future<String> getUser({
    required String userName,
    required String password,
  });
}

// Real Class
class LoginDataSourceImpl implements LoginDataSource {
  @override
  Future<String> getUser({
    required String userName,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Success User ';
  }
}

// Mock Class for testing
class MockLoginDataSource extends MockDataSource implements LoginDataSource {
  MockLoginDataSource({
    super.routeName = '/login',
    super.friendlyName = 'Login Data Source',
  });
  @override
  List<PossibleAnswer> get possibleAnswers => [
        PossibleAnswer(
          id: 1,
          label: 'User Success',
          description: 'return a success',
        ),
        PossibleAnswer(
          id: 2,
          label: 'User Error',
          description: 'return a default error',
        ),
        PossibleAnswer(
          id: 3,
          label: 'User Not Found',
          description: 'return a not found error',
        ),
      ];

  @override
  Future<String> getUser({
    required String userName,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    if (returnSelected?.id == 1) {
      registerRequest(
        name: 'Get user',
        request: 'getUser : $userName : $password',
        response: 'User Success',
      );
      return 'User Success';
    } else if (returnSelected?.id == 3) {
      registerRequest(
        request: 'getUser : $userName : $password',
        response: 'User Not Found',
        name: 'Get user',
      );
      return 'User Not Found $userName $password';
    } else if (returnSelected?.id == null) {
      return 'Success User';
    } else {
      registerRequest(
        name: 'Get user',
        request: 'getUser : $userName : $password',
        response: 'User Error $userName $password',
      );
      return 'User Error $userName $password';
    }
  }
}
