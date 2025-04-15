import 'package:Orgit/Components/Cards/cardGroup.dart';
import 'package:Orgit/Components/Modals/searchResults/itemView.dart';
import 'package:flutter/material.dart';
import 'package:Orgit/Components/Bar/SlideBar.dart';
import 'package:Orgit/Components/Inputs/customSearchbar.dart';

class Modcreategroup extends StatelessWidget {
  final TextEditingController searchControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 725,
            width: double.infinity,
            color: Color.fromARGB(255, 19, 20, 22),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SlideBar(),
                ),
                Positioned(
                    left: 55,
                    top: 40,
                    child: Text(
                      'Připojit se ke skupině',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    )),
                Positioned(
                    left: 35,
                    top: 100,
                    child: SizedBox(
                      width: 330,
                      height: 40,
                      child: Customsearchbar(
                        controller: searchControl,
                        suggestions: [
                          "ahoj",
                          "prdelko",
                          "pookie",
                          "ojel bych te"
                        ],
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 180),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Itemview(
                            textHeader: 'Skupiny v okolí',
                            textFooter: 'Zobrazit více',
                            onTapFooter: () => {print('Show more')},
                            headerFont: 20,
                            cards: List.generate(
                              4,
                              (index) => Cardgroup(
                                OnTap: () => {
                                  print(
                                      'Pripojit se do skupiny (CardGroup$index)')
                                },
                                city: 'Děčín',
                                primaryColor:
                                    const Color.fromARGB(255, 198, 197, 197),
                                secondaryColor: Colors.white30,
                                image: Image.asset(
                                  'assets/groupIcon.png',
                                ),
                                name: 'Dealy na Krátký',
                                region: 'Ústecký kraj',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Itemview(
                            textHeader: 'Všechny skupiny',
                            textFooter: 'Zobrazit více',
                            onTapFooter: () => {print('Show more')},
                            headerFont: 20,
                            cards: List.generate(
                              4,
                              (index) => Cardgroup(
                                OnTap: () => {
                                  print(
                                      'Pripojit se do skupiny (CardGroup$index)')
                                },
                                city: 'Děčín',
                                primaryColor:
                                    const Color.fromARGB(255, 198, 197, 197),
                                secondaryColor: Colors.white30,
                                image: Image.asset(
                                  'assets/groupIcon.png',
                                ),
                                name: 'Dealy na Krátký',
                                region: 'Ústecký kraj',
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
