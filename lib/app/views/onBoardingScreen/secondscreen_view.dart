import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SecondscreenView extends GetView {
  const SecondscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SecondscreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SecondscreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
