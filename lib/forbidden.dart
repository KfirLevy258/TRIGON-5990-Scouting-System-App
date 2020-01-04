import 'package:flutter/material.dart';

class ForbiddenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forbidden')
    ),
      body: Center(
        child: Text('Permission Denied')
      ),
    );
  }
}
