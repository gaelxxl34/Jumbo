import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../translation_service.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/text_strings.dart';

class CustomSliverAppBar extends StatelessWidget {
  CustomSliverAppBar({Key? key, required this.onLanguageChanged}) : super(key: key);
  final Function(String) onLanguageChanged;
  // ... other properties




  final List<DropdownMenuItem<String>> languageDropdownItems = [
    DropdownMenuItem(
      value: 'fr',
      child: Row(
        children: [
          Text('🇨🇩'), // Flag emoji for DRC (Congo)
          SizedBox(width: 8),
          Text('Français'),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'en',
      child: Row(
        children: [
          Text('🇺🇬'), // Flag emoji for Uganda
          SizedBox(width: 8),
          Text('English'),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'sw',
      child: Row(
        children: [
          Text('🇹🇿'), // Flag emoji for Tanzania
          SizedBox(width: 8),
          Text('Kiswahili'),
        ],
      ),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    final translationService = Provider.of<TranslationService>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      pinned: true,
      floating: false,
      actions: [
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: translationService.currentLanguageCode,
            items: languageDropdownItems,
            onChanged: (newValue) async {
              if (newValue != null) {
                await translationService.saveSelectedLanguage(newValue);
                onLanguageChanged(newValue);
                // Trigger a rebuild of the app or the relevant widget tree to reflect the language change
              }
            },
          ),
        ),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var top = constraints.biggest.height;
          return Stack(
            children: [
              Positioned(
                top: top / 2 - (size.height * 0.125),
                left: 0,
                right: 0,
                child: Image(image: AssetImage(TImages.appLogo), width: size.width * 0.25, height: size.height * 0.25),
              ),
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  child: TranslatedText(TTexts.logoText, style: Theme.of(context).textTheme.headlineSmall),
                ),
              ),
            ],
          );
        },
      ),
      collapsedHeight: size.height * 0.3,
      expandedHeight: size.height * 0.3,
    );
  }
}
