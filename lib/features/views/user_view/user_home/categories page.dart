import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../../authentication/controllers/network controllers/network_listener.dart';
import '../../../search/general search.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  @override
  void initState() {
    super.initState();
    NetworkListener networkController = Get.put(NetworkListener());
    networkController.addListener(_onNetworkChange);
  }

  void _onNetworkChange() {
    setState(() {
      // Trigger a rebuild when the network status changes
    });
  }

  @override
  void dispose() {
    NetworkListener networkController = Get.find();
    networkController.removeListener(_onNetworkChange);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    NetworkListener networkController = Get.find();
    return  Scaffold(
      appBar: AppBar(
        title: Text(TTexts.category),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton( onPressed: () {  },
              icon: Icon(Icons.shopping_cart,),),
          )
        ],
      ),
      body:  networkController.hasInternet
          ? Center(child: Text("welcome to categories"),)
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('check internet connection'),
          ],
        ),
      ),
    );
  }
}
