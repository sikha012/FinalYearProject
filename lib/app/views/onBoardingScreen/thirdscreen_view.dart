import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ThirdscreenView extends GetView {
  const ThirdscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThirdscreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ThirdscreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
