import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jumbo/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../../authentication/controllers/network controllers/network_listener.dart';
import '../../../search/general search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final List<String> imgList = [
    'https://cdn.pixabay.com/photo/2016/12/10/20/22/black-friday-1898111_640.jpg',
    'https://cdn.pixabay.com/photo/2016/11/07/13/20/black-friday-1805804_640.png',
    'https://cdn.pixabay.com/photo/2018/10/17/08/52/black-3753444_640.jpg',
    'https://cdn.pixabay.com/photo/2019/09/20/05/16/black-friday-4490827_640.jpg',
  ];

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
        title: Text(TTexts.accueil),
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
          ? Column(
        children: [
          // Top Container
          Container(
            width: double.infinity,
            color: TColors.primary, // Replace with TColors.primary if defined
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                'Découvrez les dernières offres!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),

          // Carousel Slider with Shimmer effect
          FutureBuilder(
            future: Future.delayed(Duration(seconds: 2)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return buildCarouselSlider();
              } else {
                return buildShimmerEffect();
              }
            },
          ),

          // Bottom Container
          Container(
            width: double.infinity,
            color: TColors.primary, // Replace with TColors.primary if defined
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Glissez pour en savoir plus', style: TextStyle(fontSize: 16, color: Colors.white)),
                Icon(Icons.arrow_forward_ios, color: Colors.white,),
              ],
            ),
          ),
        ],
      )
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


  Widget buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 2),
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: imgList.map((item) => Container(
        child: Center(
            child: Image.network(item, fit: BoxFit.cover, width: 1000)
        ),
      )).toList(),
    );
  }

  Widget buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 200,
        color: Colors.white,
      ),
    );
  }
}
