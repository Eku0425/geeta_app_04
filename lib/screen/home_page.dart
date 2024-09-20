import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modal/modal.dart';
import '../provider/detail.dart';
import '../provider/geeta_provider.dart';
import '../utils/gobal.dart';
import 'detail_page.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    Geetaprovider geetaprovider = Provider.of<Geetaprovider>(context);
    Geetaprovider geetaprovidertrue =
        Provider.of<Geetaprovider>(context, listen: true);
    DetailProvider detailProvidertrue = Provider.of(context, listen: true);
    DetailProvider detailProviderfalse = Provider.of(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: Switch(
          value: geetaprovidertrue.isDark,
          onChanged: (value) {
            geetaprovider.ChangeTheme();
          },
        ),
        centerTitle: true,
        title: Text(
          (detailProvidertrue.selectedLanguage == 'Sanskrit')
              ? translate[0]
              : (detailProvidertrue.selectedLanguage == 'Hindi')
                  ? translate[1]
                  : (detailProvidertrue.selectedLanguage == 'English')
                      ? translate[2]
                      : translate[3],
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          DropdownButton(
            value: detailProvidertrue.selectedLanguage,
            onChanged: (String? value) {
              detailProviderfalse.languageTranslate(value!);
            },
            items: <String>['Sanskrit', 'Hindi', 'English', 'Gujarati']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            SizedBox(height: 5),
            Container(
              height: h * 0.25,
              width: w * 0.90,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://i.pinimg.com/originals/c9/9e/7f/c99e7f085c029e6d2e6adf525ea3232d.gif'),
                ),
              ),
            ),
            SizedBox(height: 20),
            Flexible(
              child: ListView.builder(
                itemCount: geetaprovider.Geetalist.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        selectedIndex = index;
                        List<Verse> verses =
                            geetaprovider.Geetalist[selectedIndex].verses;
                        // Navigator.of(context).pushNamed('/detail');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomeListScreen(),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Column(
                          children: [
                            Text(
                              (detailProvidertrue.selectedLanguage ==
                                      'Sanskrit')
                                  ? translate[0]
                                  : (detailProvidertrue.selectedLanguage ==
                                          'Hindi')
                                      ? translate[1]
                                      : (detailProvidertrue.selectedLanguage ==
                                              'English')
                                          ? translate[2]
                                          : translate[3],
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${geetaprovider.Geetalist[index].chapter}',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        title: Text(
                          (detailProvidertrue.selectedLanguage == 'Sanskrit')
                              ? geetaprovider
                                  .Geetalist[index].chapterName.sanskrit
                              : (detailProvidertrue.selectedLanguage == 'Hindi')
                                  ? geetaprovider
                                      .Geetalist[index].chapterName.hindi
                                  : (detailProvidertrue.selectedLanguage ==
                                          'English')
                                      ? geetaprovider
                                          .Geetalist[index].chapterName.english
                                      : geetaprovider.Geetalist[index]
                                          .chapterName.gujarati,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Icon(Icons.list_sharp),
                            Text(
                                '${geetaprovider.Geetalist[index].verses.length}'),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              (detailProvidertrue.selectedLanguage ==
                                      'Sanskrit')
                                  ? Shlok[0]
                                  : (detailProvidertrue.selectedLanguage ==
                                          'Hindi')
                                      ? Shlok[1]
                                      : (detailProvidertrue.selectedLanguage ==
                                              'English')
                                          ? Shlok[2]
                                          : Shlok[3],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_right,
                          size: 40,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
