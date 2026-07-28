// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practical_google_maps_example/core/styling/app_styles.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final List<Map<String, dynamic>> items = [
    {'title': 'Orders', 'onPressed': () => print('Orders pressed')},
    {'title': 'Add Order', 'onPressed': () => print('Add Order pressed')},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: AppStyles.primaryHeadLinesStyle
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: items[index]['onPressed'],
              child: Card(
                color: Theme.of(context).primaryColor,
                margin: const EdgeInsets.all(5.0),
                child: Center(
                  child: Text(
                    items[index]['title']!,
                    style: AppStyles.black16w500Style.copyWith(fontSize: 23.sp),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
