import 'package:orgit/components/cards/card_group.dart';
import 'package:orgit/components/modals/mdl_item_view.dart';
import 'package:flutter/material.dart';
import 'package:orgit/components/Bar/slide_bar.dart';
import 'package:orgit/components/Inputs/custom_searchbar.dart';
import 'package:orgit/services/auth/auth.dart';

class Modcreategroup extends StatefulWidget {
  @override
  State<Modcreategroup> createState() => _ModcreategroupState();
}

class _ModcreategroupState extends State<Modcreategroup> {
  final TextEditingController searchControl = TextEditingController();

  Future<void> _handleJoinGroup(BuildContext context, String groupName) async {
    try {
      // Simulate successful group joining
      // TODO: Replace with actual API call when backend is ready
      print("Joining group: $groupName");

      // Update cache to mark user as being in a group
      final authService = AuthService();
      // await authService.updateInGroupStatus(true);

      if (context.mounted) {
        // Close the modal
        Navigator.of(context).pop();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Úspěšně jste se připojili ke skupině "$groupName"!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to homepage
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/homepage',
          (route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Chyba při připojování ke skupině: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

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
                        hintText: "Hledej skupinu",
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
                                onTap: () => _handleJoinGroup(
                                    context, 'Dealy na Krátký'),
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
                                onTap: () => _handleJoinGroup(
                                    context, 'Dealy na Krátký'),
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
