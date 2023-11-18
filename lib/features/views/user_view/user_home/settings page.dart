import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jumbo/utils/constants/text_strings.dart';
import 'package:provider/provider.dart';

import '../../../../repository/authentification_repository/authentification_repository.dart';
import '../../../../translation_service.dart';
import '../../../authentication/controllers/network controllers/network_listener.dart';
import '../../../search/general search.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool isAccountExpanded = false;
  bool isLanguageExpanded = false;
  String selectedLanguage = 'fr';
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
        title: Text(TTexts.settingTitle),
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
          ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
                    children: [
                      ListTile(
                        title: Text('Compte', style: TextStyle(fontSize: 18),),
                        leading: Icon(Icons.person, size: 30,),
                        trailing: Icon(isAccountExpanded ? Icons.expand_less : Icons.expand_more),
                        onTap: () {
                          setState(() {
                            isAccountExpanded = !isAccountExpanded;
                          });
                        },
                      ),
                      if (isAccountExpanded) ...[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(

                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    hintText: 'Nom d\'utilisateur',
                                  ),
                                ),
                                SizedBox(height: 8,),
                                TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email_outlined),
                                    hintText: 'Email',
                                  ),
                                ),
                                SizedBox(height: 8,),
                                TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.phone),
                                    hintText: 'Telephone',
                                  ),
                                ),
                                SizedBox(height: 8,),
                                SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Update profile logic
                                    },
                                    child: Text('Update Profile'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      SizedBox(height: 12,),
                      ListTile(
                          leading: Icon(CupertinoIcons.info_circle_fill, size: 30,),
                          title: Text("A propos", style: TextStyle(fontSize: 18),),
                      ),
                      SizedBox(height: 12,),
                      ListTile(
                          leading: Icon(CupertinoIcons.exclamationmark_shield_fill, size: 30),
                          title: Text("Aide", style: TextStyle(fontSize: 18)),
                      ),

                      SizedBox(height: 12,),
                      ListTile(
                        title: Text('Langue', style: TextStyle(fontSize: 18),),
                        leading: Icon(Icons.language, size: 30,),
                        trailing: Icon(isLanguageExpanded ? Icons.expand_less : Icons.expand_more),
                        onTap: () {
                          setState(() {
                            isLanguageExpanded = !isLanguageExpanded;
                          });
                        },
                      ),
                      if (isLanguageExpanded) ...[
                        DropdownButton<String>(
                          value: selectedLanguage,
                          onChanged: (String? newValue) {
                            setState(() {
                              if (newValue != null) {
                                selectedLanguage = newValue;
                              }
                            });
                          },
                          items: [
                            DropdownMenuItem(
                              value: 'fr',
                              child: Row(
                                children: [
                                  Text('🇨🇩 '), // DRC Flag Emoji
                                  Text('Français'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],


            SizedBox(height: 20),
            // Add more settings options here
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  AuthentificationRepository.instance.logout();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('SE DECONNECTER', style: TextStyle(fontSize: 18),),
                    SizedBox(width: 8,),
                    Icon(Icons.logout)
                  ],
                ),
              ),
            )
    ]
    )
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









}
