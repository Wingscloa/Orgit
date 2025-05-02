import 'package:flutter/material.dart';
import 'package:orgit/components/cards/card_group.dart';
import 'package:orgit/components/Modals/mdl_item_view.dart';
import 'package:orgit/components/Bar/slide_bar.dart';
import 'package:orgit/components/Inputs/custom_searchbar.dart';

class Mdlgroupjoin extends StatefulWidget {
  @override
  State<Mdlgroupjoin> createState() => _MdlgroupjoinState();
}

class _MdlgroupjoinState extends State<Mdlgroupjoin> {
  final TextEditingController searchControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 725,
      child: Container(
        height: 725,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 19, 20, 22),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(27),
            topRight: Radius.circular(27),
          ),
        ),
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
                    suggestions: ["ahoj", "prdelko", "pookie", "ojel bych te"],
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: 180),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Itemview(
                        textHeader: 'Skupiny v okolí',
                        opened: true,
                        textFooter: 'Zobrazit více',
                        onTapFooter: () => {print('Show more')},
                        headerFont: 20,
                        cards: List.generate(
                          4,
                          (index) => Cardgroup(
                            onTap: () => {
                              print('Pripojit se do skupiny (CardGroup$index)')
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
                            onTap: () => {
                              print('Pripojit se do skupiny (CardGroup$index)')
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
    );
  }
}
