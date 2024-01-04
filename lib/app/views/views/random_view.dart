import 'package:flutter/material.dart';

import 'package:get/get.dart';

class RandomView extends GetView {
  const RandomView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RandomView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RandomView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
