import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumbo/utils/constants/image_strings.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo and Text
              Row(
                children: [
                  Image.asset(TImages.appleLogo, height: 20), // Replace with your logo asset
                  SizedBox(width: 10),
                  Text('Jumia'),
                ],
              ),
      
              // Search Bar and Button
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search on Jumbo',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Implement search logic
                      },
                      child: Text('Search'),
                    ),
                  ],
                ),
              ),
      
              // Account and Help Dropdowns
              DropdownButton<String>(
                value: 'Account',
                items: <String>['Account', 'Profile', 'Orders'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Implement dropdown logic
                },
              ),
              DropdownButton<String>(
                value: 'Help',
                items: <String>['Help', 'Support', 'Contact Us'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Implement dropdown logic
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Text('Web Home Page Content Here'),
        ),
      ),
    );
  }
}
