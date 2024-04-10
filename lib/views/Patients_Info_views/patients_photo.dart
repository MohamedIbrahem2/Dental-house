import 'dart:async';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import '../../test/qr_code.dart';

class PatientPhoto extends StatefulWidget {
  const PatientPhoto({Key? key}) : super(key: key);

  @override
  State<PatientPhoto> createState() => _PatientPhotoState();
}

class _PatientPhotoState extends State<PatientPhoto> {
  late int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,

        body: GenerateQRCode(),
    );
  }
}
