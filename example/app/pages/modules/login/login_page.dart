import 'package:flutter/material.dart';

import 'login_data_source.dart';

class LoginPage extends StatefulWidget {
  final LoginDataSource dataSource;
  const LoginPage({
    super.key,
    required this.dataSource,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final isButtonLoading = ValueNotifier(false);
  final userName = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: userName,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Username is required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: password,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        isButtonLoading.value = true;
                        final scaffoldMessenger = ScaffoldMessenger.of(context);
                        final response = await widget.dataSource.getUser(
                          userName: userName.text,
                          password: password.text,
                        );
                        isButtonLoading.value = false;
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text(response.toString()),
                          ),
                        );
                      }
                    },
                    child: ValueListenableBuilder(
                      valueListenable: isButtonLoading,
                      builder: (context, value, child) {
                        if (value) {
                          return const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const Text('Login');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/home');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.forward),
      ),
    );
  }
}
