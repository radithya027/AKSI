import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/masuk.controller.dart';

class MasukScreen extends GetView<MasukController> {
  const MasukScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MasukScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MasukScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
