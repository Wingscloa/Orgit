import 'package:flutter/material.dart';
import 'package:orgit/components/cards/card_group.dart';
import 'package:orgit/components/Modals/mdl_item_view.dart';
import 'package:orgit/components/Bar/slide_bar.dart';
import 'package:orgit/components/Inputs/custom_searchbar.dart';
import 'package:orgit/utils/responsive_utils.dart';

class Mdlgroupjoin extends StatefulWidget {
  @override
  State<Mdlgroupjoin> createState() => _MdlgroupjoinState();
}

class _MdlgroupjoinState extends State<Mdlgroupjoin> {
  final TextEditingController searchControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight * 0.9, // 90% výšky obrazovky
      child: Container(
        height: screenHeight * 0.9,
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
              padding: EdgeInsets.only(
                  top: ResponsiveUtils.getSpacingMedium(context)),
              child: SlideBar(),
            ),
            Positioned(
                left: ResponsiveUtils.getPaddingHorizontal(context),
                top: screenHeight * 0.04,
                child: Text(
                  'Připojit se ke skupině',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: ResponsiveUtils.getHeadingFontSize(context),
                  ),
                )),
            Positioned(
                left: ResponsiveUtils.getPaddingHorizontal(context) * 0.8,
                top: screenHeight * 0.13,
                child: SizedBox(
                  width: screenWidth * 0.85,
                  height: ResponsiveUtils.getButtonHeight(context) * 0.6,
                  child: Customsearchbar(
                    hintText: "Klub poctivých skautu",
                    controller: searchControl,
                    suggestions: ["ahoj", "prdelko", "pookie", "ojel bych te"],
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.22),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Itemview(
                        textHeader: 'Skupiny v okolí',
                        opened: true,
                        textFooter: 'Zobrazit více',
                        onTapFooter: () => {print('Show more')},
                        headerFont:
                            ResponsiveUtils.getSubtitleFontSize(context),
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
                        height: ResponsiveUtils.getSpacingLarge(context),
                      ),
                      Itemview(
                        textHeader: 'Všechny skupiny',
                        textFooter: 'Zobrazit více',
                        onTapFooter: () => {print('Show more')},
                        headerFont:
                            ResponsiveUtils.getSubtitleFontSize(context),
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
