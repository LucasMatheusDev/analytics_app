import 'package:flutter/material.dart';

import 'home_data_source.dart';

class MyHomePage extends StatefulWidget {
  final HomeDataSource dataSource;
  const MyHomePage({
    super.key,
    required this.dataSource,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: FutureBuilder(
        future: widget.dataSource.getResponse(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Home Page',
                  ),
                  Text(
                    snapshot.data.toString(),
                  ),
                  Text(
                    '$counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
